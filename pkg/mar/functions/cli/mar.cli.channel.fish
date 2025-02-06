function mar.cli.channel
  switch (count $argv)
    case 0
      mar.channel.get

    case 1
      mar.channel.set $argv

    case '*'
      echo (mar::err)"Invalid number of arguments"(mar::off) >&2
      mar help channel
      return $MAR_INVALID_ARG
  end
end
