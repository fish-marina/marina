function mar.packages.remove -a pkg

  if not mar.packages.valid_name $pkg
    echo (mar::err)"$pkg is not a valid package/theme name"(mar::off) >&2
    return $MAR_INVALID_ARG
  end

  if test $pkg = "mar" -o $pkg = "default"
    echo (mar::err)"You can't remove `$pkg`"(mar::off) >&2
    return $MAR_INVALID_ARG
  end

  for path in {$MAR_PATH,$MAR_CONFIG}/pkg/$pkg
    test -d $path;
      and set found;
      or continue

    # Run uninstall hook first.
    mar.packages.run_hook $path uninstall
    if test -f $path/uninstall.fish
      source $path/uninstall.fish 2> /dev/null
    end
    emit uninstall_$pkg
    emit {$pkg}_uninstall

    if command rm -rf $path
      mar.bundle.remove "package" $pkg
      return 0
    else
      return 1
    end
  end

  for path in {$MAR_PATH,$MAR_CONFIG}/themes/$pkg
    test -d $path;
      and set found;
      or continue

    test $pkg = (cat $MAR_CONFIG/theme);
      and echo default > $MAR_CONFIG/theme

    if command rm -rf $path
      mar.bundle.remove "theme" $pkg
      return 0
    else
      return 1
    end
  end

  set -q found; or return 2
end
