function mar.cli.list
  switch (count $argv)
  case 0
    echo (set_color -u)Plugins(set_color normal)
    mar.packages.list --plugin | column
    echo
    echo (set_color -u)Themes(set_color normal)
    mar.packages.list --theme | column
  case '*'
    mar.packages.list $argv | column
  end
end
