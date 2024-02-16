# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

# Added by Andy
setopt extended_glob 		# Not sure this is needed or a good idea?  I must have it for a reason?

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[3~' delete-char                       # delete
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[H' beginning-of-line                  # home
bindkey '^[[F' end-of-line                        # end
bindkey '^[[Z' undo                               # shift + tab undo last action

# Enable the great ZMV - improved version of mv for renaming files
# https://blog.thecodewhisperer.com/permalink/renaming-magically-with-zmv
# autoload zmv

# History configurations
HISTFILE=~/.zsh_history
SAVEHIST=10000000
HISTSIZE=10000000
#setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
#setop HIST_IGNORE_ALL_DUPS
setopt hist_ignore_dups       # ignore duplicated commands history list
#setopt hist_ignore_space      # ignore commands that start with space
#setopt share_history         # share command history data
setopt hist_verify            # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY


###############################################################
# My PATH modifications

# Convention here is that the line order matters.  
#  Existing PATH is first, only append additions at the end.

origPATH="$PATH"

#pyenv wins for that start
export PATH="$HOME/.pyenv/bin"

#PATH START - kali bin folder comes next
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/mobile-hacking-mac"

#PATH MIDDLE - here's the rest
export PATH="$PATH:$HOME/.jenv/bin"
export PATH="$PATH:$HOME/.cargo/bin"

#PATH END - append original path, so it's actually at the end.
export PATH="$PATH:$origPATH"

###############################################################
# pyenv stuff which also modifies path

if type "pyenv" >/dev/null; then
	# pyenv is installed
	export PYENV_VIRTUALENV_DISABLE_PROMPT=1
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

if type "jenv" >/dev/null; then
	# jenv is installed
	eval "$(jenv init -)"
fi

###############################################################

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    
	if type "pyenv" >/dev/null; then
    	PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)──}(%B%F{%(#.red.blue)}%n|%m|z%b%F{%(#.blue.green)})-[$(pyenv version-name| awk -F\'/\' \'{print $3 ? $3 : $0}\')]-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
    else
    	PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)──}(%B%F{%(#.red.blue)}%n|%m|z%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '    	
    fi
    RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
	. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[default]=none
	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[path]=underline
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[command-substitution]=none
	ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[process-substitution]=none
	ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[assign]=none
	ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
	ZSH_HIGHLIGHT_STYLES[named-fd]=none
	ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
	ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%# '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a'
    ;;
*)
    ;;
esac

new_line_before_prompt=yes
precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$new_line_before_prompt" = yes ]; then
	if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
	    _NEW_LINE_BEFORE_PROMPT=1
	else
	    print ""
	fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto -i'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
elif [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
	#statements
	source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

	# change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'
fi

###############################################################
# CUSTOM EXPORTS - ENVIRONMENT VARIABLES

export EDITOR="vim"

###############################################################
# My custom functions and aliases

# Important shell function
function f__my_figcow () {
	figlet "$@" | cowsay -n
}

function pause_for_user_confirm() {
  # Confirm with user
  read -s -k '?Press any key to continue...'
  printf "\n\n"
}

# PS and grep combo
function f__ps_grep () {
	ps -e | \egrep -i --color=auto "PID TTY|$1"
}

# Get My IP addresses
function f__get_my_ips () {
	echo "eth0 IP: $(ifconfig |  grep -A1 'eth0'| grep 'inet ' | tr -s ' ' | cut -d' ' -f3)";
	echo "tun0 IP: $(ifconfig |  grep -A1 'tun0'| grep 'inet ' | tr -s ' ' | cut -d' ' -f3)";
	echo "Public IP: $(curl -s icanhazip.com)";
}

function f__listening () {
	sudo lsof -iTCP -sTCP:LISTEN -n -P
}

function f__print_command_accelerators () {
	read -r -d '' reminders <<- EOM
	!$ gets the last element of the previous command line argument.
	!:3 gets you the third one 
	!* gets you all of em 
	!! gets you the entire last command. Useful if you forgot to use sudo. 
	!:1-2 gets you all but the last of 3 arguments 
	!frida -- yank the last used command from history that starts with 'frida' and put it on the command line
	!?pinning -- same as previous, but search anywhere in history lines

	CMD-shift-A -- select and copy output of last command
	CTRL+U -- delete whole line
	CTRL+K -- delete rest of line
EOM
	
	printf "Shell previous command accelerators:\n%s\n" "$reminders"
}

function f__get_path () {
	# Needs to be a function to allow this to work at runtime

	echo "$PATH" | tr \\: \\\n
}

function f__install_autosuggest() {
	# Reference: zsh-autosuggestions
	# https://github.com/zsh-users/zsh-autosuggestions
	# https://software.opensuse.org/download.html?project=shells%3Azsh-users%3Azsh-autosuggestions&package=zsh-autosuggestions
	echo "About to install ZSH zsh-autosuggestions using curl commands and sudo apt install / yum."
	pause_for_user_confirm

	if type "yum" >/dev/null; then
		# Try the yum approach
		sudo yum install git
		git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
		# Edit this file to add this:
		echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
	else
		# Maybe we're on Ubuntu
		echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-autosuggestions/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-autosuggestions.list
		curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-autosuggestions.gpg > /dev/null
		sudo apt update
		sudo apt install zsh-autosuggestions
	fi
}


###############################################

# Sudo alias fix.  'll' available in sudo!
alias sudo='sudo '

# Some more ls aliases
alias ll='ls -l -a -h'
alias la='ls -l -h'
alias l='la'

alias showpath="f__get_path"
alias pathshow="showpath"

# Install stuff
alias install-autosuggest="f__install_autosuggest"

# force zsh to show the complete history
alias history="history 0"
alias histg="history | \fgrep --color=auto -i"
alias histe="history | \egrep --color=auto -i"
alias hist="\history -100"
alias hsit="\history -100"
#alias locate="mdfind -name"  # MDFIND IS WAY BETTER THAN LOCATE ON A MAC.

alias bang="f__print_command_accelerators"
alias hg="histg"

alias figcow="f__my_figcow"
alias figsay="f__my_figcow"

alias psg="f__ps_grep"
alias listen="f__listening"

alias fh="la | egrep -i" # fh = find here
alias mip="f__get_my_ips"  # My IP addresses
alias update_history="fc -IR"
alias space="ncdu"
alias tree="tree -a" # Make tree alway show hidden files.  Interesting gotcha.
alias strsearch="strsearch.sh"

alias profile="subl ~/.zshrc"

alias landroid="if [[ -d ~/bin ]]; then ls ~/bin; else ls ~/mobile-hacking-mac; fi | grep -i andr"
alias lios="if [[ -d ~/bin ]]; then ls ~/bin; else ls ~/mobile-hacking-mac; fi | grep -i ios"
alias lmac="if [[ -d ~/bin ]]; then ls ~/bin; else ls ~/mobile-hacking-mac; fi | grep -i mac"


###############################################
# Need these below the PATH changes above.
# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump  # the -d option rebuilds the database every time
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

