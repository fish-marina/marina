# SYNOPSIS
#   Change the current working directory to plugin / theme home directory.
#
# OPTIONS
#   <name> Name of the package or theme.

function mar.packages.cd -a name -d "Change the current working directory to plugin / theme home directory."
  if test -z "$name"
    pushd $MAR_PATH
    return 0
  end

  for path in {$MAR_CONFIG,$MAR_PATH}/{pkg,themes}/$name
    if test -e "$path"
      pushd $path
      return 0
    end
  end

  echo (mar::err)"$name is not a valid package/theme name"(mar::off) >&2
  return $MAR_INVALID_ARG
end
