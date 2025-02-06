function mar.theme.set -a target_theme
  if not test -d $MAR_PATH/themes/$target_theme -o -d $MAR_CONFIG/themes/$target_theme
    return $MAR_INVALID_ARG
  end

  if test -f $MAR_CONFIG/theme
    read current_theme < $MAR_CONFIG/theme
    test "$target_theme" = "$current_theme"; and return 0
  end

  set -l prompt_filename "fish_prompt.fish"
  set -l user_functions_path (mar.xdg.config_home)/fish/functions

  mkdir -p "$user_functions_path"

  if not mar.check.fish_prompt
    echo (mar::err)"Conflicting prompt setting."(mar::off)
    echo "Run "(mar::em)"mar doctor"(mar::off)" and fix issues before continuing."
    return $MAR_INVALID_ARG
  end

  # Replace autoload paths of current theme with the target one
  set -q current_theme
    and autoload -e {$MAR_CONFIG,$MAR_PATH}/themes/$current_theme{,/functions}
  set -l theme_path {$MAR_CONFIG,$MAR_PATH}/themes*/$target_theme{,/functions}
  autoload $theme_path

  # Find target theme's fish_prompt and link to user function path
  for path in {$MAR_CONFIG,$MAR_PATH}/themes/$target_theme/$prompt_filename
    if test -e $path
      ln -sf $path $user_functions_path/$prompt_filename; and break
    end
  end

  # Reload fish key bindings if reload is available and needed
  functions -q __fish_reload_key_bindings
    and test -e $MAR_CONFIG/key_bindings.fish -o -e $MAR_PATH/key_bindings.fish
    and __fish_reload_key_bindings

  # Load target theme's conf.d files
  for conf in {$MAR_CONFIG,$MAR_PATH}/themes/$target_theme/conf.d/*.fish
    source $conf
  end

  # Persist the changes
  echo "$target_theme" > "$MAR_CONFIG/theme"

  return 0
end
