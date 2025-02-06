function mar.repo.pull -a repo_dir branch
  function __mar.repo.git -V repo_dir
    command git -C "$repo_dir" $argv
  end

  if test -z "$branch"
    set branch (__mar.repo.git symbolic-ref -q --short HEAD)
  end

  set -l remote origin
  if test (__mar.repo.git config --get remote.upstream.url)
    set remote upstream
  end

  set initial_branch (__mar.repo.git symbolic-ref -q --short HEAD);
    or return 1
  set initial_revision (__mar.repo.git rev-parse -q --verify HEAD);
    or return 1

  # the refspec ensures that '$remote/$branch' gets updated
  set -l refspec "refs/heads/$branch:refs/remotes/$remote/$branch"
  __mar.repo.git fetch --quiet $remote $refspec;
    or return 1

  if test (__mar.repo.git rev-list --count "$branch"...FETCH_HEAD) -eq 0
    return 2
  end

  if not __mar.repo.git diff --quiet
    echo (mar::em)"Stashing your changes:"(mar::off)
    __mar.repo.git status --short --untracked-files
    __mar.repo.git stash save --include-untracked --quiet;
      and set stashed
  end

  if test "$initial_branch" != "$branch"
    __mar.repo.git checkout "$branch" --quiet
  end

  if not __mar.repo.git merge --ff-only --quiet FETCH_HEAD
    __mar.repo.git checkout $initial_branch
    __mar.repo.git reset --hard $initial_revision
    set -q stashed; and __mar.repo.git stash pop
    return 1
  end

  if test "$initial_branch" != "$branch"
    __mar.repo.git checkout $initial_branch --quiet
  end

  if set -q stashed
    __mar.repo.git stash pop --quiet

    echo (mar::em)"Restored your changes:"(mar::off)
    __mar.repo.git status --short --untracked-files
  end

  return 0
end
