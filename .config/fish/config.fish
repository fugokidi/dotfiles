# copied from https://github.com/fatih/dotfiles/blob/main/config.fish
set -gxp PATH /opt/homebrew/bin
set -gx EDITOR vim
set -gx FZF_CTRL_T_COMMAND vim
# tmux in the server does not work without this
set -gx TERM xterm-256color

# shell integration, if we don't set it, working directory features won't work
set -gx GHOSTTY_SHELL_INTEGRATION_XDG_DIR /Applications/Ghostty.app/Contents/Resources/ghostty/shell-integration

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim

# don't show any greetings
set fish_greeting ""

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command
end

if status is-interactive
    # Managing dot files (https://www.atlassian.com/git/tutorials/dotfiles)
    # curl -Lks https://gist.githubusercontent.com/fugokidi/4d8323de0e24be09a5df272d1a2628e3/raw/bb5427f8ea2c23dcbad6928dbda45e4777ffe8a8/cfg.sh | /bin/bash
    alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
end
