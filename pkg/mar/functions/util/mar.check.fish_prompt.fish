function mar.check.fish_prompt
  set -l prompt_file "fish_prompt.fish"
  set -l theme (cat $MAR_CONFIG/theme)

  set -l user_functions_path (mar.xdg.config_home)/fish/functions
  set -l fish_prompt (readlink "$user_functions_path/$prompt_file" 2> /dev/null)

  not test -e "$fish_prompt"; and return 0
  contains -- "$fish_prompt" {$MAR_CONFIG,$MAR_PATH}/themes/$theme/$prompt_file
end
