# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# http://selena.deckelmann.usesthis.com/

# Loading plugins, setting variables{{{
export CODEDIR=$HOME/Code
if [[ -e $HOME/.dotfiles_location ]]; then
  export DOTFILES=$(cat $HOME/.dotfiles_location)
else
  export DOTFILES=$HOME/Code/dotfiles
  echo "~/.dotfiles_location not found, reinstall dotfiles"
fi

# brew must be in path before zshuery
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

source $DOTFILES/vendor/zsh-hl/zsh-syntax-highlighting.zsh
source $DOTFILES/zshuery/zshuery.sh
load_defaults
load_aliases
load_lol_aliases
load_completion $DOTFILES/zshuery/completion
load_correction

for dir in $DOTFILES/bin/*(/); do
  export PATH=$dir:$PATH
done
[[ -d /opt/gradle    ]] && export PATH=/opt/gradle/bin:$PATH
[[ -d /opt/kindlegen ]] && export PATH=/opt/kindlegen:$PATH
[[ -d /opt/gae_go    ]] && export GOROOT=/opt/gae_go/goroot \
  && export GOBIN=$GOROOT/bin && export PATH=/opt/gae_go:$GOBIN:$PATH
export PATH=$DOTFILES/bin:$HOME/.cljr/bin:$HOME/.cabal/bin:$PATH
if [[ $HAS_BREW == 1 ]]; then
  BREWGO=$(brew --prefix go)
  [[ -d $BREWGO ]] && export GOROOT=$BREWGO && export GOBIN=$BREWGO/bin \
    && export GOPATH=$GOROOT && export PATH=$GOBIN:$PATH
  source "$(brew --prefix grc)/etc/grc.bashrc"
fi

export PYTHONDONTWRITEBYTECODE=true
export VIRTUALENV_DISTRIBUTE=true
export PIP_USE_MIRRORS=true
export PYTHONSTARTUP=$DOTFILES/pythonrc.py
export CLICOLOR="yes"
export EDITOR="vim"
export PAGER="less"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;33;146m'
export LESS="-R"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LEDGER_FILE=$HOME/Documents/my.ledger
if [[ $IS_MAC == 1 ]]; then
  export HAXE_LIBRARY_PATH="$(brew --prefix)/share/haxe/std"
  export JAVA_HOME=/Library/Java/Home
fi
# }}}
# Custom settings, aliases and functions {{{
source $DOTFILES/rc
psack() { ps auxww | ack $* | ack -v ack | collapse | cut -d' ' -f 2,11- }
alias "ps?"=psack
cljv() { curl -s https://clojars.org/$1 | grep version | head -n 1 | sed -e "s/<[a-z\/=\" ]*>//g" -e "s/&lt;[\/a-z]*&gt;//g" }
dighost() { host $(dig $1 | grep ANSWER -C 1 | tail -n 1 | awk '{ print $5 }') }
echoarrow() { echo "$fg_bold[black]====> $fg_no_bold[yellow]$*$reset_color" }
updatestuff() {
  echoarrow "Updating dotfiles w/ submodules" && (cd $DOTFILES && git pull && git su)
  [[ $HAS_BREW == 1 ]] && echoarrow "Updating Homebrew" && brew update
  [[ -e $HOME/.rbenv ]] && echoarrow "Updating rbenv"    && (cd $HOME/.rbenv && git pull)
}

chpwd() { update_terminal_cwd; }
precmd() {
  # $? in prompt is wrong, can't pass %? to conditionals
  if [[ $? == 0 ]]; then SMILEY=')'; else SMILEY='('; fi
}

prompts '%{$fg_bold[green]%}$(COLLAPSED_DIR)%{$reset_color%} %{$fg_no_bold[yellow]%}:$SMILEY%{$reset_color%} ' '%{$fg[red]%}$(ruby_version)%{$reset_color%}'
setopt auto_pushd
bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey "\e[3~" delete-char # Del
# }}}

# Have to load these plugins after... something
source $DOTFILES/vendor/zsh-hss/zsh-history-substring-search.zsh
eval "$($DOTFILES/bin/fasd/fasd --init auto)"
source $HOME/.zshrc.local

[[ -e $(which fortune) ]] && fortune | (cowsay || cat) 2&> /dev/null | (lolcat || cat) 2&>/dev/null

