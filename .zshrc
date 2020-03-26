# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git kubectl golang)

source $ZSH/oh-my-zsh.sh

# User configuration

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

if [ -n "$DESKTOP_SESSION" ];then

		eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
		export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
		dbus-update-activation-environment --systemd DISPLAY

    #eval $(gnome-keyring-daemon --start)
    #export SSH_AUTH_SOCK
fi
