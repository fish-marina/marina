function mar -d "Marina"
  # Parse any options before the command name.
  while set -q argv[1]
    switch $argv[1]
      case '-h' '--help'
        set command help

      case '-v' '--version'
        set command version

      case '-*'
        echo (mar::err)"Unknown option: $argv[1]"(mar::off) >&2
        return $MAR_UNKNOWN_OPT

      case '*'
        break
    end

    set -e argv[1]
  end

  # Also extract a help flag from the last argument.
  switch "$argv[-1]"
    case '-h' '--help'
      set command help
      set -e argv[-1]
  end

  # Extract the command name from the remaining arguments.
  if not set -q command
    if set -q argv[1]
      set command $argv[1]
      set -e argv[1]
    else
      set command help
    end
  end

  # Lookup the function for the requested command.
  if not set command_name (mar.command $command)
    echo (mar::err)"Unknown command: $command"(mar::off) >&2
    return $MAR_UNKNOWN_OPT
  end

  # Execute the command.
  echo "function __mar_last_command --no-scope-shadowing
    mar.cli.$command_name \$argv
  end" | source

  __mar_last_command $argv
end
