function mar.packages.name -a name_or_url
  command basename $name_or_url | sed -E 's/^(mar-)?((plugin|pkg|theme)-)?//;s/\\.git$//'
end
