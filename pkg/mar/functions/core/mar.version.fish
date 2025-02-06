function mar.version
  command git -C "$MAR_PATH" describe --tags --match 'v*' --always | cut -c 2-
end
