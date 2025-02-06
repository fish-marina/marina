# Path to Marina install.
set -q XDG_DATA_HOME
  and set -gx MAR_PATH "$XDG_DATA_HOME/mar"
  or set -gx MAR_PATH "$HOME/.local/share/mar"

# Customize Marina configuration path.
#set -gx MAR_CONFIG "{{MAR_CONFIG}}"

# Load marina configuration.
source $MAR_PATH/init.fish
