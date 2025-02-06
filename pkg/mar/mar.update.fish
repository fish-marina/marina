function mar.update -a name
  function __mar.update.success
    echo (mar::em)"✔ $argv successfully updated."(mar::off)
  end

  function __mar.update.error
    echo (mar::err)"Could not update $argv."(mar::off) >&2
  end

  if test \( -e $MAR_PATH/themes/$name \) -o \( -e $MAR_CONFIG/themes/$name \)
    set install_type "theme"
    set parent_path "themes"
  else
    set install_type "package"
    set parent_path "pkg"
  end

  for path in {$MAR_PATH,$MAR_CONFIG}/pkg/$name
    not test -e "$path/.git"; and continue

    mar.repo.pull $path; and set return_success

    set -q return_success;
      and mar.bundle.install $path/bundle
  end

  set -q return_success; and __mar.update.success "$name"
end
