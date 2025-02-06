function mar.cli.search -d 'Searches all available packages'
  switch (count $argv);
    case 1;
      mar.index.update --if-missing

      echo (mar::under)"Plugins"(mar::off)
      __mar.cli.search.output --type=plugin --text=$argv[1]
      echo
      echo (mar::under)"Themes"(mar::off)
      __mar.cli.search.output --type=theme --text=$argv[1]

    case 2;
      mar.index.update --if-missing

      switch "$argv[1]"
        case "-p" "--plugin";
          __mar.cli.search.output --type=plugin --text=$argv[2]
        case "-t" "--theme";
          __mar.cli.search.output --type=theme --text=$argv[2]
        case '*';
          mar.cli.help search
          return 1
      end

    case '*';
      mar.cli.help search
      return 1
  end

  return 0
end

function __mar.cli.search.output
  for package in (mar.index.query $argv)
    set -l desc (mar.index.stat $package description)
    echo "$package - $desc"
  end
end
