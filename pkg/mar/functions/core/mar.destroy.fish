function mar.destroy -d "Remove Marina"
  # Run the uninstaller
  fish "$MAR_PATH/bin/install" --uninstall "--path=$MAR_PATH" "--config=$MAR_CONFIG"

  # Start a new MAR-free shell
  set -q CI; or exec fish < /dev/tty
end
