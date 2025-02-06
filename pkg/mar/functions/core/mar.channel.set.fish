function mar.channel.set -a name
  # If an argument is specified, set the update channel.
  if begin; test -z "$name"; or not contains -- $name stable dev; end
    echo (mar::err)"'$name' is not a valid channel."(mar::off) >&2
    return 1
  end

  echo $name > $MAR_CONFIG/channel
  echo "Update channel set to "(mar::em)"$name"(mar::off)"."
  echo "To switch to the latest $name version, run "(mar::em)"mar update"(mar::off)"."
end
