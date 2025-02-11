function mar.packages.update -a name
  if set -l props (mar.index.stat $name branch)
    set branch $props[1]
    if test -z "$branch"
      set branch "main"
    end
  end

  if not set target_path (mar.packages.path $name)
    echo (mar::err)"Could not find $name."(mar::off) >&2
    return 1
  end

  # Only pull packages in version control
  if test -e $target_path/.git
    mar.repo.pull $target_path "$branch"
    switch $status
      case 0
        mar.bundle.install $target_path/bundle
        set result (mar::em)"$name successfully updated."(mar::off)
      case 1
        echo (mar::err)"Could not update $name."(mar::off) >&2
        return 1
      case 2
        set result (mar::dim)"$name is already up-to-date."(mar::off)
    end
  end

  # Run update hook.
  if not mar.packages.run_hook $target_path update
    echo (mar::err)"Could not update $name."(mar::off) >&2
    return 1
  end

  if set -q result
    echo $result
  end
  return 0
end
