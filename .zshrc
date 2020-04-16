autoload -Uz compinit
compinit

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
HIST_STAMPS="yyyy-mm-dd"

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# You may need to manually set your language environment
export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

alias vim="nvim"
export GOPATH="$HOME/git/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"

#export WAYLAND_DISPLAY=alacritty

function list_all() {
    emulate -L zsh
    ls -a
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# fix ssh deamon for term when we are not in gnome shell
if [ -n "$DESKTOP_SESSION" ];then
		eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
		export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
		dbus-update-activation-environment --systemd DISPLAY
fi

source <(antibody init)

antibody bundle denysdovhan/spaceship-prompt
antibody bundle zsh-users/zsh-completions
source <(kubectl completion zsh)

#most be last plugins:
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle zsh-users/zsh-history-substring-search

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if [[ -n "$terminfo[kcuu1]" ]]; then
  bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
fi
if [[ -n "$terminfo[kcud1]" ]]; then
  bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
  bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
fi

alias ls="ls --color=tty"
alias l="ls -l --color=tty"
alias la="ls -la --color=tty"
