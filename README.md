
# The [Fishshell](http://fishshell.com) Framework

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE) [![Fish Shell Version](https://img.shields.io/badge/fish-≥v2.2.0-007EC7.svg?style=flat-square)](http://fishshell.com) [![Build](https://github.com/fish-marina/marina/workflows/Build/badge.svg)](https://github.com/fish-marina/marina/actions?query=workflow%3ABuild)

> ⚠️ Marina is currently in the process of being renamed from Oh My Fish. While this takes place some links in the
> documentation may still point to Oh My Fish instead

Marina provides core infrastructure to allow you to install packages which extend or modify the look of your shell.
It's fast, extensible and easy to use.

Marina is a hard fork of Oh My Fish. Marina strives to remain compatible to Oh My Fish and Fisher(man) packages.

> Also in
> [🇪🇸](./docs/es-ES/README.md)
> [🇳🇱](./docs/nl-NL/README.md)
> [🇧🇷](./docs/pt-BR/README.md)
> [🇷🇺](./docs/ru-RU/README.md)
> [🇺🇦](./docs/uk-UA/README.md)
> [🇨🇳](./docs/zh-CN/README.md)

## Table of contents

* [Installation](#installation)
* [Getting Started (command descriptions)](#getting-started)
* [Advanced](#advanced)
  * [Startup](#startup)
  * [Dotfiles](#dotfiles)
* [Creating Packages](#creating-packages)

## Installation

You can get started right away with the default setup by running this in your terminal:

```fish
curl https://raw.githubusercontent.com/fish-marina/marina/master/bin/install | fish
```

This will download the installer script and start the installation. Alternatively, you can download the installer and customize your install:

```fish
curl https://raw.githubusercontent.com/fish-marina/marina/master/bin/install > install
fish install --path=~/.local/share/mar --config=~/.config/mar
```

You can verify the integrity of the downloaded installer by verifying the script against [this checksum](bin/install.sha256):

```
curl -sL https://raw.githubusercontent.com/fish-marina/marina/master/bin/install.sha256 | shasum -a 256 --check
```

You can also install Marina with Git or with an offline source tarball downloaded from the [releases page][releases]:

```fish
# with git
$ git clone https://github.com/fish-marina/marina
$ cd marina
$ bin/install --offline
# with a tarball
$ curl https://raw.githubusercontent.com/fish-marina/marina/master/bin/install > install
$ fish install --offline=mar.tar.gz
```

Run `install --help` for a complete list of install options you can customize.

#### Requirements

- **fish** shell, version 2.2 or later
- **git**, version 1.9.5 or later

#### Known Issues

- Due to a regression bug in fish 2.6 with some terminal emulators, right prompts make the shell unusable.
  MAR's `default` theme features a right prompt, so it's necessary to use an alternative theme until a fix is released.
  (see [#541](https://github.com/fish-marina/marina/issues/541))


## Getting Started

Marina includes a small utility `mar` to fetch and install new packages and themes.

#### `mar update` _`[mar]`_ _`[<package>...]`_

Update Marina, all package repositories, and all installed packages.

- When called without arguments, update core and all installed packages.
- You can choose to update only the core, by running `mar update mar`.
- For selective package update, list only the names of packages you wish to
  update. You may still include "mar" in the list to update the core as well.

#### `mar install` _`[<name>|<url>|<user/repo>]`_

Install one _or more_ packages.

- You can install packages directly by URL via `mar install URL`
- You can install packages from a GitHub repository via `mar install user/repo`
- When called without arguments, install missing packages from [bundle](#dotfiles).

#### `mar repositories` _`[list|add|remove]`_

Manage user-installed package repositories. Package repositories are where packages come from used by commands like `mar install`. By default the [official repository](https://github.com/marina/packages) is always installed and available.

#### `mar list`

List installed packages.

#### `mar theme` _`<theme>`_

Apply a theme. To list available themes, type `mar theme`. You can also [preview available themes](./docs/Themes.md) before installing.

#### `mar remove` _`<name>`_

Remove a theme or package. If a package was installed via `user/repo`, use `repo` for `name`.

> Packages can use uninstall hooks, so custom cleanup of resources can be done when uninstalling it. See [Uninstall](/docs/en-US/Packages.md#uninstall) for more information.

#### `mar reload`

Reload Marina and all plugins by using `exec` to replace current shell process with a brand new.

> This command tries to be as safe as possible, mitigating side-effects caused by `exec` and preventing the reload in case of background processes.

#### `mar new plugin | theme` _`<name>`_

Scaffold out a new plugin or theme.

> This creates a new directory under `$MAR_CONFIG/{pkg | themes}/` with a template.

#### `mar search` _`-t|--theme / -p|--package`_ _`<name>`_

Searches Marina's database for a given package, theme or both. It also supports fuzzy search, so if you are not sure of the name you can simply `mar search simple`.

#### `mar channel`

Gets or changes the update channel.

Two channels are available by default: the `stable` channel provides stable updates with the latest tagged version of Marina, and `dev` which provides the latest changes under development. The update channel currently set determines what version `mar update` will upgrade to.

#### `mar doctor`

Use to troubleshoot before [opening an issue][mar-issues-new].

#### `mar destroy`

Uninstall Marina.

## Advanced

Marina installer adds a snippet to fish's user config files (`~/.config/fish/conf.d/`) which calls MAR's startup code.

Notice that the scripts in that directory are sourced in the order that the filesystem sees them,
and so it may be necessary to prefix your script files with ordering numbers.

For example: `a_script.fish` will take precedence over the `mar.fish` snippet.
So if `a_script.fish` depends on plugins managed by MAR, consider renaming the script file to `xx_a_script.fish`.

Similarly, to make sure that a script runs before `mar.fish`, you may prefix it with `00_`.
Alternatively, `~/.config/mar/before.init.fish` may be used.

### Startup

Every time you open a new shell, the startup code initializes Marina installation path and the _config_ path (`~/.config/mar` by default),
sourcing the [`init.fish`](init.fish) script afterwards, which autoloads packages, themes and your custom init files.

For more information check the [FAQ](docs/en-US/FAQ.md#what-does-oh-my-fish-do-exactly).

### Dotfiles

The `$MAR_CONFIG` directory represents the user state of Marina. It is the perfect
candidate for being added to your dotfiles and/or checked out to version control. There you can find three important files:

- __`theme`__ - The current theme
- __`bundle`__ - List of currently installed packages/themes
- __`channel`__ - The channel from which MAR gets updates (stable / dev)

And you may create and customize these special files:

- __`init.fish`__ - Custom script sourced after shell start
- __`before.init.fish`__ - Custom script sourced before shell start
- __`key_bindings.fish`__ - Custom key bindings where you can use the `bind` command freely

#### Setting variables in `init.fish`

One of the most common startup commands used in `init.fish` is variables definition. Quite likely, such variables need to be available in any shell session. To achieve this, define them globally. For example:

```fish
# Golang developers might need this one
set -xg GOPATH $HOME/gocode

# Python developers otherwise
set -xg PYTHONDONTWRITEBYTECODE 1
```

#### About the bundle

Every time a package/theme is installed or removed, the `bundle` file is updated. You can also edit it manually and run `mar install` afterwards to satisfy the changes. Please note that while packages/themes added to the bundle get automatically installed, a package/theme removed from bundle isn't removed from user installation.

#### Older fish versions

In fish 2.2, there is no `conf.d` directory, so the startup code has to be placed in the fish config file (`~/.config/fish/config.fish`).

It's highly recommended that your custom startup commands go into `init.fish` file instead of `~/.config/fish/config.fish`, as this allows you to keep the whole `$MAR_CONFIG` directory under version control.

If you need startup commands to be run *before* Marina begins loading plugins, place them in `before.init.fish` instead. If you're unsure, it is usually best to put things in `init.fish`.

## Creating Packages

Marina uses an advanced and well defined plugin architecture to ease plugin development, including init/uninstall hooks, function and completion autoloading. [See the packages documentation](docs/en-US/Packages.md) for more details.

[mar-issues-new]: https://github.com/fish-marina/marina/issues/new
[releases]: https://github.com/fish-marina/marina/releases
