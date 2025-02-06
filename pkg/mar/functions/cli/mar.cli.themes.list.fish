function mar.cli.themes.list
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
end
