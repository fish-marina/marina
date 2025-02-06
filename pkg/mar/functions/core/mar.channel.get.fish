function mar.channel.get
  # Check for an environment variable override.
  if set -q MAR_CHANNEL
    echo $MAR_CHANNEL
    return 0
  end

  # Check the channel file.
  if test -f $MAR_CONFIG/channel
    read -l channel < $MAR_CONFIG/channel
      and echo $channel
      and return 0
  end

  # Assume 'stable' if not specified.
  echo stable
end
