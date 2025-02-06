function mar.cli.remove -a name
  switch (count $argv)
  case 1
    mar.packages.remove $name
    set code $status

    switch $code
    case 0
      echo (mar::em)"$name successfully removed."(mar::off)
      # Opt-in flag for testing
      set -q MAR_AUTO_RELOAD
        and mar.reload
    case 1
      echo (mar::err)"$name could not be removed."(mar::off) >&2
    case 2
      echo (mar::err)"$name could not be found."(mar::off) >&2
    end

    return $code

  case '*'
    echo (mar::err)"Invalid number of arguments"(mar::off) >&2
    echo "Usage: mar remove "(mar::em)"<name>"(mar::off) >&2
    return $MAR_INVALID_ARG
  end
end
