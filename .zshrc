# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit
compinit

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_SPACE
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
export PATH="$PATH:$HOME/bin:/usr/local/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
#export PATH="$PATH:/usr/lib/go-1.14/bin"
export GOROOT="/home/napoleon/.go"
export GOTOOLDIR="/home/napoleon/.go/pkg/tool/linux_amd64"

function list_all() {
    emulate -L zsh
    ls -a
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

if [[ -n keychain ]]; then
     eval $(keychain --eval --quick --quiet --agents ssh id_rsa)
fi

source <(antibody init)

antibody bundle romkatv/powerlevel10k
#antibody bundle denysdovhan/spaceship-prompt
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
alias ll="ls -l --color=tty"
alias la="ls -la --color=tty"
#alias bazel="bazelisk"

alias python="python3"
alias pip="python3 -m pip"

alias kubectl="env $(grep -hv '^#' $HOME/.kops.env $HOME/.aws.env | xargs) kubectl"
alias kops="env $(grep -hv '^#' $HOME/.kops.env | xargs) kops"

source $HOME/.fzf/shell/key-bindings.zsh
source $HOME/.fzf/shell/completion.zsh

if [[ -n cron ]]; then 
    sudo /etc/init.d/cron start &> /dev/null
fi

bindkey -e

alias activate_qmk="$HOME/qmk_utils/activate_wsl.sh"

alias update_go="curl -LO https://get.golang.org/$(uname)/go_installer && chmod +x go_installer && ./go_installer && rm go_installer"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/home/napoleon/.go/bin

export PATH=$PATH:/home/napoleon/git/go/bin
