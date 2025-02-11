function mar.core.update
  # If on the stable channel, checkout the latest tag.
  if test (mar.channel.get) = stable
    # If the channel isn't explicitly set and we are currently tracking a branch instead of a version, the user probably
    # upgraded from an old version. Let them know that we will start updating to stable versions.
    if begin; not test -f $MAR_CONFIG/channel; and command git -C "$MAR_PATH" symbolic-ref -q HEAD > /dev/null; end
      set_color yellow --bold 2> /dev/null
      echo ">> You have been switched to the stable release channel of Marina."
      echo ">> To switch back to the development channel, run `mar channel dev`."
      set_color normal 2> /dev/null
    end

    # Determine the remote to fetch from.
    set -l remote origin
    if test (command git -C "$MAR_PATH" config --get remote.upstream.url)
      set remote upstream
    end

    # Fetch the latest tags.
    command git -C "$MAR_PATH" fetch --quiet --tags $remote
      # Get the commit for the latest release.
      and set -l hash (command git -C "$MAR_PATH" rev-list --tags='v*' --max-count=1 2> /dev/null)
      # Get the release tag.
      and set -l tag (command git -C "$MAR_PATH" describe --tags $hash 2> /dev/null)
      # Checkout the release.
      and command git -C "$MAR_PATH" checkout --quiet tags/$tag
      and return 0

    # Something went wrong.
    echo (mar::err)"No release versions found."(mar::off)
    return 1
  else
    # Determine the branch to use for the dev channel.
    set -q MAR_DEV_BRANCH
      or set -l MAR_DEV_BRANCH main

    # Switch to the main branch if we are in a detached head.
    command git -C "$MAR_PATH" symbolic-ref -q HEAD > /dev/null
      or command git -C "$MAR_PATH" checkout $MAR_DEV_BRANCH --quiet

    # Pull the latest for the current branch.
    mar.repo.pull $MAR_PATH
  end
end
