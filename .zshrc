# Created by newuser for 4.3.12

# [[ -z "$PS1" ]] && return

autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors
PROMPT="[%?] %{$fg_bold[yellow]%}%n%# %{$reset_color%}"
RPROMPT="%{$fg_bold[green]%}%~%{$reset_color%}"

export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
export HISTSIZE=2000
export HISTFILE=~/.zsh_history
export SAVEHIST=2000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don't write over existing files with >, use >! instead
setopt NOCLOBBER

# Don't nice backgound processes
setopt NO_BG_NICE

alias 'ls=ls --color=auto'
alias 'rm=rm -i'
alias 'mv=mv -i'
alias 'cp=cp -i'
alias 'emacs=emacs -nw'
alias 'grep=grep --color=auto'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bemkap/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
