function mar.cli.update
  set -l update_core
  set -l packages $argv
  if test (count $packages) -gt 0
    # If several packages are listed, only update core if "mar" is listed among them.
    # Also keep "mar" out of the list of packages to update.
    set index (contains -i -- mar $packages)
      and set -e packages[$index]
      or set -e update_core
  else
    set packages (mar.packages.list)
  end

  if set -q update_core
    mar.core.update

    if type -q mar.version
      set MAR_VERSION (mar.version)
    end

    if test $status -ne 1
      echo (mar::em)"Marina is up to date."(mar::off)
      echo (mar::em)"You are now using Marina version $MAR_VERSION."(mar::off)
    else
      echo (mar::err)"Marina failed to update."(mar::off)
      echo "Please open a new issue here → "(mar::em)"https://github.com/fish-marina/marina/issues"(mar::off)
    end
  end

  mar.index.update
    or return 1

  for package in $packages
    mar.packages.update $package
  end

  # Opt-in flag for testing
  if set -q MAR_AUTO_RELOAD
    mar.reload
  end
end
