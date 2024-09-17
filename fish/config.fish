if status is-interactive
    set -g fish_greeting
    starship init fish | source
    set -gx EDITOR micro
    set -gx VISUAL $EDITOR
    set -gx PAGER less
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx MICRO_TRUECOLOR 1
    set -gx PATH $HOME/.cargo/bin $PATH
    set -Ux fish_user_paths $HOME/bin $fish_user_paths
    alias ls "exa --icons --group-directories-first"
    alias ll "exa -l --icons --group-directories-first"
    alias la "exa -la --icons --group-directories-first"
    alias tree "exa --tree --icons"
    alias cat "bat"
    alias g "git"
    if type -q fzf
        set -gx FZF_DEFAULT_COMMAND "fd --type file --follow --hidden --exclude .git"
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        fzf_key_bindings
    end
    if type -q zoxide
        zoxide init fish | source
    end
    if type -q thefuck
        thefuck --alias | source
    end
    function mkcd
        mkdir -p $argv && cd $argv
    end
    if test -f ~/.config/fish/local.fish
        source ~/.config/fish/local.fish
    end
end

for file in ~/.config/fish/functions/*.fish
    source $file
end
