function __mar.packages.new.mkdir -a name
  set -l name "$argv[1]"
  if test -d "$MAR_CONFIG"
    set name "$MAR_CONFIG/$name"
  else if test -d "$MAR_PATH"
    set name "$MAR_PATH/$name"
  end
  mkdir -p "$name"
  echo $name
end

function __mar.packages.new.from_template -a path github user name
  for file in $path/*
    if test -d $file
      mkdir (basename $file)
      pushd (basename $file)
      __mar.packages.new.from_template $file $github $user $name
    else
      set -l target (begin
        if test (basename $file) = "{{NAME}}.fish"
          echo "$name.fish"
        else
          echo (basename "$file")
        end
      end)
      set -l year (date +%Y)
      sed "s/{{USER_NAME}}/$user/;s/{{GITHUB_USER}}/$github/;s/{{NAME}}/$name/;s/{{YEAR}}/$year/" \
        $file > $target
      echo (mar::em)" create "(mar::off)" "(begin
        if test (basename $PWD) = $name
          echo ""
        else
          echo (basename "$PWD")"/"
        end
      end)$target
    end
  end
  popd >/dev/null 2>&1
end


function mar.packages.new -a option name
  switch $option
    case "p" "plugin"
      set option "pkg"
    case "t" "th" "the" "thm" "theme" "themes"
      set option "themes"
    case "*"
      echo (mar::err)"$option is not a valid option."(mar::off) >&2
      return $MAR_INVALID_ARG
  end

  if not mar.packages.valid_name "$name"
    echo (mar::err)"$name is not a valid package/theme name"(mar::off) >&2
    return $MAR_INVALID_ARG
  end

  if set -l dir (__mar.packages.new.mkdir "$option/$name")
    cd $dir

    set -l github (git config github.user)
    test -z "$github"; and set github "{{USER}}"

    set -l user (git config user.name)
    test -z "$user"; and set user "{{USER}}"

    __mar.packages.new.from_template "$MAR_PATH/pkg/mar/templates/$option" \
      $github $user $name

    echo (mar::em)"Switched to $dir"(mar::off)
  else
    echo (mar::err)"\$MAR_CONFIG and/or \$MAR_PATH undefined."(mar::off) >&2
    exit $MAR_UNKNOWN_ERR
  end
end
