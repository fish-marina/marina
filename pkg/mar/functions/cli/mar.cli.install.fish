function mar.cli.install
  set fail_count 0

  mar.index.update
    or return 1

  switch (count $argv)
  case 0
    mar.bundle.install;
      or set fail_count 1
  case '*'
    for package in $argv
      mar.packages.install $package;
        and require $package

      # If package is a theme, set it to active.
      set -l themes (mar.packages.list --theme)
      if contains -- $package $themes
        mar.theme.set $package
      else if set -l ind (contains -i -- (mar.packages.name $package) $themes)
        mar.theme.set $themes[$ind]
      end

      test $status != 0;
        and set fail_count (math $fail_count + 1)
    end
  end

  return $fail_count
end
