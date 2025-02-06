function __mar.packages.install.success
  echo (mar::em)"✔ $argv successfully installed."(mar::off)
end

function __mar.packages.install.error
  echo (mar::err)"Could not install $argv."(mar::off) >&2
end

function __mar.packages.install.error.already
  echo (mar::err)"Error: $argv already installed."(mar::off) >&2
end

function mar.packages.install -a name_or_url
  if set -l props (mar.index.stat $name_or_url type repository branch)
    set package_type $props[1]
    set name $name_or_url
    set url $props[2]
    set branch $props[3]
  else
    set name (mar.packages.name $name_or_url)
    set branch ""
    if string match -qi -r "^[a-z\d-]+/[a-z\d\-\._]+\$" $name_or_url
      set url "https://github.com/$name_or_url"
    else
      set url $name_or_url
    end
  end

  if contains -- $name (mar.packages.list)
    __mar.packages.install.error.already "$name_or_url"
    return $MAR_INVALID_ARG
  end

  echo (mar::dim)"Installing package $name"(mar::off)

  set -l install_dir $MAR_PATH/pkg/$name

  # Clone the package repository.
  if not mar.repo.clone $url $branch $install_dir
    __mar.packages.install.error "$name"
    return $MAR_UNKNOWN_ERR
  end

  # If we don't know the package type yet, check if the package is a theme.
  if not set -q package_type
    test -f $install_dir/fish_prompt.fish -o -f $install_dir/functions/fish_prompt.fish
      and set package_type theme
      or set package_type plugin
  end

  # If the package is a theme, move it to the themes directory.
  if test $package_type = theme
    test -d $MAR_PATH/themes
      or command mkdir -p $MAR_PATH/themes

    command mv $install_dir $MAR_PATH/themes/$name
    set install_dir $MAR_PATH/themes/$name

    mar.bundle.add theme $name_or_url
  else
    mar.bundle.add package $name_or_url
  end

  mar.bundle.install $install_dir/bundle

  # Run the install hook.
  if not mar.packages.run_hook $install_dir install
    __mar.packages.install.error "$name"
    return $MAR_UNKNOWN_ERR
  end

  __mar.packages.install.success "$name"

  return 0
end
