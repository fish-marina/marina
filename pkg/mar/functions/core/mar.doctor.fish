function __mar.doctor.theme
  if not mar.check.fish_prompt
    echo (mar::err)"Warning: "(mar::off)(mar::em)"fish_prompt.fish"(mar::off)" is overridden."
    echo (mar::em)"  fish_config"(mar::off)" command persists the prompt to "(mar::em)"~/.config/fish/functions/fish_prompt.fish"(mar::off)
    echo "  That file takes precedence over Marina's themes. Remove the file to fix it:"
    echo (mar::em)"  rm ~/.config/fish/functions/fish_prompt.fish"(mar::off)
    echo

    return 1
  end

  return 0
end

function __mar.doctor.fish_version
  set -l min_version 3.0.0
  set -l current_version
  begin
    echo $FISH_VERSION | read -la --delimiter - version_parts
    set current_version "$version_parts[1]"
  end

  if not mar.check.version $min_version $current_version
    echo (mar::err)"Warning: "(mar::off)"Marina requires "(mar::em)"fish"(mar::off)" version "(mar::em)"$min_version"(mar::off)" or above"
    echo "Your fish version is "(mar::em)$FISH_VERSION(mar::off)
    echo
    return 1
  end
end

function __mar.doctor.git_version
  set -l min_version 1.9.5
  set -l current_version
  begin
    git --version | read -la version_parts
    set current_version "$version_parts[3]"
  end

  if not mar.check.version $min_version $current_version
    echo (mar::err)"Warning: "(mar::off)"Marina requires "(mar::em)"git"(mar::off)" version "(mar::em)"$min_version"(mar::off)" or above"
    echo "Your git version is "(mar::em)$current_version(mar::off)
    echo
    return 1
  end
end

function mar.doctor
  echo "Marina version:   "(mar.version)
  echo "OS type:              "(uname)
  echo "Fish version:         "(fish --version)
  echo "Git version:          "(git --version)
  echo "Git core.autocrlf:    "(git config core.autocrlf; or echo no)

  __mar.doctor.fish_version; or set -l doctor_failed
  __mar.doctor.git_version; or set -l doctor_failed
  __mar.doctor.theme; or set -l doctor_failed

  fish "$MAR_PATH/bin/install" --check
    or set -l doctor_failed

  if set -q doctor_failed
    echo "If everything you use Marina for is working fine, please don't worry and just ignore the warnings. Thanks!"
  else
    echo (mar::em)"Your shell is ready to swim."(mar::off)
  end
end
