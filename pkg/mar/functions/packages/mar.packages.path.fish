function mar.packages.path -a name
  for path in {$MAR_CONFIG,$MAR_PATH}/{themes,pkg}/$name
    if test -e $path
      echo $path
      return 0
    end
  end

  return 1
end
