function mar.cli.new
  if test (count $argv) -ne 2
    echo (mar::err)"Package type or name missing"(mar::off) >&2
    return $MAR_MISSING_ARG
  end
  mar.packages.new $argv
end
