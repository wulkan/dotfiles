#!/bin/bash

OMZDIR="$HOME/.oh-my-zsh"
if [ ! -d "$OMZDIR" ]; then
	echo 'Installing oh-my-zsh'
	/bin/sh -c "$(curl =fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

TPM="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM" ]; then
	echo 'Installing tmux plugin manager'
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	$HOME/.tmux/plugins/tpm/bin/install_plugins
else
	echo 'Updating tmux plugins'
	$HOME/.tmux/plugins/tpm/bin/update_plugins all
fi
