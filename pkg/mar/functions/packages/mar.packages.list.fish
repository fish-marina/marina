set -l builtin_packages {$MAR_PATH,$MAR_CONFIG}/pkg*/{mar,fish-spec}


function mar.packages.list -d 'List installed packages'
  set -l show_plugins
  set -l show_themes

  if begin; contains -- --plugin $argv; or contains -- -p $argv; end
    set -e show_themes
  end

  if begin; contains -- --theme $argv; or contains -- -t $argv; end
    set show_themes
    set -e show_plugins
  end

  set -l plugins_paths {$MAR_PATH,$MAR_CONFIG}/pkg/*
  set -l themes_paths {$MAR_PATH,$MAR_CONFIG}/themes/*

  if set -q show_plugins
    for path in $plugins_paths
      contains $path $builtin_packages; or command basename $path
    end
  end

  if set -q show_themes
    for path in $themes_paths
      command basename $path
    end
  end
end
