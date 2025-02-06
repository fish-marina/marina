set -g MAR_MISSING_ARG   1
set -g MAR_UNKNOWN_OPT   2
set -g MAR_INVALID_ARG   3
set -g MAR_UNKNOWN_ERR   4

function mar::em
  set_color cyan 2> /dev/null
end

function mar::dim
  set_color 555 2> /dev/null
end

function mar::err
  set_color red --bold 2> /dev/null
end

function mar::under
  set_color --underline 2> /dev/null
end

function mar::off
  set_color normal 2> /dev/null
end

autoload $path/functions/{compat,core,index,packages,themes,bundle,util,repo,cli,search}
