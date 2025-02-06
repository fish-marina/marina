# SYNOPSIS
#   Completions for Marina CLI

complete -c mar -f -d "Marina"

function __mar_assert_args_count -a count
    set -l cmd (commandline -poc)
    set -e cmd[1]
    test (count $cmd) -eq $count
end

set -l installed_themes (mar.packages.list --theme)
set -l installed_plugins (mar.packages.list --plugin)
set -l installed $installed_themes $installed_plugins
for subcommand in "r rm remove" "c cd" "u update"
  complete -c mar -f -n "__fish_seen_subcommand_from $subcommand; and __mar_assert_args_count 1" -a "$installed_themes" -d theme
  complete -c mar -f -n "__fish_seen_subcommand_from $subcommand; and __mar_assert_args_count 1" -a "$installed_plugins" -d plugin
end

set -l available_themes (mar.index.query --type=theme)
set -l available_plugins (mar.index.query --type=plugin)
for subcommand in "i install" "d describe"
  complete -c mar -f -n "__fish_seen_subcommand_from $subcommand" -a "$available_themes" -d theme
  complete -c mar -f -n "__fish_seen_subcommand_from $subcommand" -a "$available_plugins" -d plugin
end

complete -c mar -f -n "__fish_seen_subcommand_from d desc describe" -a (printf "%s " (mar.index.query --type=plugin))
complete -c mar -f -n "__fish_seen_subcommand_from t theme"         -a "$installed_themes"
complete -c mar -f -n "__fish_seen_subcommand_from channel"         -a "stable dev"
complete -c mar -f -n "__fish_seen_subcommand_from help"            -a "cd channel describe destroy doctor help install get list ls new reload remove uninstall repo repositories search theme update version"

complete -c mar -f -a cd       -n "__fish_use_subcommand" -d "Change directory to plugin/theme directory"
complete -c mar -f -a channel  -n "__fish_use_subcommand" -d "Gets or changes the update channel"
complete -c mar -f -a describe -n "__fish_use_subcommand" -d "Get information about what packages do"
complete -c mar -f -a destroy  -n "__fish_use_subcommand" -d "Remove Marina"
complete -c mar -f -a doctor   -n "__fish_use_subcommand" -d "Troubleshoot Marina"
complete -c mar -f -a help     -n "__fish_use_subcommand" -d "Display this help"
complete -c mar -f -a install  -n "__fish_use_subcommand" -d "Install one or more packages"
complete -c mar -f -a list     -n "__fish_use_subcommand" -d "List local packages"
complete -c mar -f -a new      -n "__fish_use_subcommand" -d "Create a new package from a template"
complete -c mar -f -a reload   -n "__fish_use_subcommand" -d "Reload the current shell"
complete -c mar -f -a remove   -n "__fish_use_subcommand" -d "Remove a theme or package"
complete -c mar -f -a repositories -n "__fish_use_subcommand" -d "Manage package repositories"
complete -c mar -f -n "__fish_seen_subcommand_from repo repositories; and __mar_assert_args_count 1" -a add -d "Add a package repository"
complete -c mar -f -n "__fish_seen_subcommand_from repo repositories; and __mar_assert_args_count 1" -a list -d "List installed repositories"
complete -c mar -f -n "__fish_seen_subcommand_from repo repositories; and __mar_assert_args_count 1" -a remove -d "Remove a package repository"
complete -c mar -f -a search   -n "__fish_use_subcommand" -d "Search for a plugin or theme"
complete -c mar -f -a theme    -n "__fish_use_subcommand" -d "Activate and list available themes"
complete -c mar -f -a update   -n "__fish_use_subcommand" -d "Update Marina"
complete -c mar -f -a version  -n "__fish_use_subcommand" -d "Display version"
