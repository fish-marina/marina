function mar.cli.theme -a name
  switch (count $argv)
  case 0
    test -f $MAR_CONFIG/theme
      and read -l theme < $MAR_CONFIG/theme
      or set -l theme default

    set -l regex_current "(^|[[:space:]])($theme)([[:space:]]|\$)"
    set -l highlight_current s/"$regex_current"/"\1"(mar::em)"\2"(mar::off)"\3"/g

    echo (mar::under)"Installed:"(mar::off)
    mar.packages.list --theme | column | sed -E "$highlight_current"
    echo
    echo (mar::under)"Available:"(mar::off)
    mar.index.query --type=theme | column
  case 1
    if not mar.theme.set $name
      echo (mar::err)"Theme not installed!"(mar::off)
      echo Install it using (mar::em)mar install $name(mar::off)
      return $MAR_INVALID_ARG
    end
  case '*'
    echo (mar::err)"Invalid number of arguments"(mar::off) >&2
    echo "Usage: $_ "(mar::em)"t"(mar::off)"heme [<theme name>]" >&2
    return $MAR_INVALID_ARG
  end
end
