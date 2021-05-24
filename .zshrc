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
autoload zmv

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

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    
    PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)──}(%B%F{%(#.red.blue)}%n%(#.x.|)%m%b%F{%(#.blue.green)})-[$(pyenv version-name| awk -F\'/\' \'{print $3 ? $3 : $0}\')]-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
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
fi

###############################################################
# My PATH modifications



# Convention here is that the line order matters.  
#  Existing PATH is first, only append additions at the end.

origPATH="$PATH"

#pyenv wins for that start
export PATH="$HOME/.pyenv/bin"

#PATH START - kali bin folder comes next
export PATH="$PATH:$HOME/bin/kali"
export PATH="$PATH:$HOME/bin"

#PATH MIDDLE - here's the rest
export PATH="$PATH:$HOME/.jenv/bin"
export PATH="$PATH:$HOME/.cargo/bin"

#PATH END - append original path, so it's actually at the end.
export PATH="$PATH:$origPATH"


###############################################################
# pyenv stuff which also modifies path
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# jEnv!
eval "$(jenv init -)"


###############################################################
# Other script includes

# Got my jump scripts! via the "z" module
# https://github.com/rupa/z
_Z_CMD=j
source /home/osboxes/opt/z_jump_script/z.sh


###############################################################
# CUSTOM EXPORTS - ENVIRONMENT VARIABLES

export TARG_DNS_SERVER=""
export TARG_NETMASK="192.168.57.x"
export TARG_DOMAIN=""
export TARG_HOST="192.168.57.114"
export TARG_MASSCAN="192.168.57.0/24"

export EDITOR="vim"

###############################################################
# My custom functions and aliases

function f__source_var_setter () {
	# Shell function to source my "environment variable setter" script
	source ~/bin/kali/var_setter.sh

}

# Important shell function
function f__my_figcow () {
	figlet "$@" | cowsay -n
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


###############################################

# Some more ls aliases
alias ll='ls -l -a -h'
alias la='ls -l -h'
alias l='la'

alias showpath="f__get_path"
alias pathshow="showpath"

alias histg="history | \fgrep --color=auto -i"
alias histe="history | \egrep --color=auto -i"
alias hist="\history -100"
alias hsit="\history -100"

alias bang="f__print_command_accelerators"
alias hg="histg"

alias figcow="f__my_figcow"
alias figsay="f__my_figcow"

alias psg="f__ps_grep"
alias listen="f__listening"
alias fh="la | egrep -i" # fh = find here
alias mip="f__get_my_ips"  # My IP addresses
alias update_history="fc -IR"
alias nownow="date +\"%Y-%m-%d--%H-%M\""
alias space="ncdu"
alias profile="sublime ~/.zshrc"
alias tree="tree -a" # Make tree alway show hidden files.  Interesting gotcha.

alias py="python"

# Make all scripts in ~/bin and ~/bin/kali executable.
# me = make executable
# em = typo of "me"
alias me="chmod +x ~/bin/*.sh; chmod +x ~/bin/kali/*.sh"
alias me2="(chmod +x *.py; chmod +x *.sh; chmod +x *.zsh)2>/dev/null"
alias em="me"

alias showvars="f__source_var_setter"
alias setvars="f__source_var_setter -set"
alias clearvars="f__source_var_setter -clear"
alias setvar="setvars"
alias set="setvars"
alias showvar="showvars"
alias show="showvars"
alias var="showvars"
alias vars="showvars"
alias keys="tmux-show-keys.sh"
alias clip="xclip -selection c"

alias ga="git add -A && git status"
alias gc="git commit -m"
alias gp="git push"
alias gs="git status"

alias repane="tmux respawn-pane -k"
alias reshell="stty -a | head -n 1 | cut -d' ' -f4-7 | sed 's/;//g' | awk '{print \"Command to run:\nstty \" \$0}' && stty raw -echo; fg"

alias sortip="sort -t . -k 3,3n -k 4,4n"
alias grepip="\egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

alias grephost='grep -r -P -s "$TARG_HOST(?![0-9])" ./*'
alias grephost-here='grep -P -s "$TARG_HOST(?![0-9])" ./*'

alias lnmap="la ~/bin/kali/nmap*; cat ~/.zshrc | grep nmap"
alias lsmb="la ~/bin/kali/smb*; cat ~/.zshrc | grep smb"
alias ldns="la ~/bin/kali/dns*; cat ~/.zshrc | grep dns"
alias lgrep="cat ~/.zshrc | grep grep"
alias lbin="la ~/bin/kali/*"

alias -g colorip="egrep ('[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'|'\|')"

alias locate="locate -i"  # Need that case insensitve locate! dang.


alias cat="/home/osboxes/go/src/github.com/jingweno/ccat/ccat --bg dark "

alias nmap_udp_1='sudo env "TARG_HOST=$TARG_HOST" /home/osboxes/bin/kali/nmap5.sh'
alias nmap_udp_2='sudo env "TARG_HOST=$TARG_HOST" /home/osboxes/bin/kali/nmap6.sh'

########## Nmap / nmap smb stuff below 

my_separator="-------------------------------------------------\n\n"
alias -g filter-nmap-script="awk '/Host script results/' RS=\"Nmap scan report for \" ORS=\"$my_separator\""

function filter-files-for-targ-host(){  # Grep - crap - I double scripted this..
	# -r = recurse subdirectories
	# -P = Perl regex support
	# -s = suppress "this is a directory" error messages
	grep -r -P -s "${TARG_HOST}(?![0-9])" ./*
}

function filter-smb-brute-files-verbose() {
	find . -type f -not -iname "smb-brute-account-results*" \
	| xargs awk '/Valid credentials/' RS="Nmap scan report for " ORS="$my_separator"
}

function filter-smb-brute-files() {
	# Filters and sorts the output from the smb-brute nmap script
	sepchar=$(printf "\x01")
	filter-smb-brute-files-verbose \
	| egrep ('[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'|'\|') \
	| sed -E 's/(^[0-9].*$)/\n\n\1/g' \
	| tr "\n" "$sepchar" \
	| sed -E "s/${sepchar}${sepchar}+/\n/g" \
	| sortip \
	| sed -E 's/$/\n/' \
	| tr "${sepchar}" "\n" \
	| \grep .
}

function filter-vuln-files-verbose() {
	find . -type f -not -iname "smb-vuln-summary-results-*" \
	| xargs awk '/VULNERABLE/' RS="Nmap scan report for " ORS="$my_separator"
}

function filter-vuln-files() {
	# Filters and sorts the output from nmap scripts
	sepchar=$(printf "\x01")
	filter-vuln-files-verbose \
	| egrep ('[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'|'\|') \
	| sed -E 's/(^[0-9].*$)/\n\n\1/g' \
	| tr "\n" "$sepchar" \
	| sed -E "s/${sepchar}${sepchar}+/\n/g" \
	| sortip \
	| sed -E 's/$/\n/' \
	| tr "${sepchar}" "\n" \
	| \grep .
}

function prior_work() {
	# Uses aliased (colorized) egrep
	filter-smb-brute-files-verbose \
	| egrep ('[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'|'\|') \
	| sed -E 's/(^[0-9].*$)/\n\1/g' 
	#| awk '{$1=$1}1' RS='' OFS='\1' \
  	#| sortip \
  	#| awk '{$1=$1}1' FS='\1' OFS=' ' ORS='\n\n'
}



##############################################################################################################
# Masscan
##############################################################################################################


alias masscan='sudo docker run -it --network host --rm -v `pwd`:/output -w /output adarnimrod/masscan'

function run-masscan-smb() {
	# Use masscan to scan common smb ports
	outfile_tmp="smb-masscan-tmp.txt"
	outfile="smb-masscan-1.txt"
	my_masscan_cmd_smb="masscan -p139,445 \"\$TARG_MASSCAN\" --rate=1000 -e tun0 --wait 1 -oL $outfile_tmp"

	printf "Command to run:\n${my_masscan_cmd_smb}\n"
	eval ${my_masscan_cmd_smb}

	printf "SMB Results:\n"
	awk '/tcp/ {print $4,$3 }' "$outfile_tmp" | sortip |\
	awk '{  seen[$1]=="" ? (seen[$1] = $2) : (seen[$1] = seen[$1] "," $2) } END { for (i in seen) print i "\t" seen[i] }' | sortip | tee "$outfile"

	rm -f "$outfile_tmp"
}

function run-masscan-http() {
	# Use masscan to scan common http ports
	outfile_tmp="http-masscan-tmp.txt"
	outfile="http-masscan-1.txt"
	my_masscan_cmd_smb="masscan -p80,8080,8081,8090,9090,443,8443,9443 \"\$TARG_MASSCAN\" \
	--rate=1000 -e tun0 --wait 1 -oL $outfile_tmp"

	printf "Command to run:\n${my_masscan_cmd_smb}\n\n"
	eval ${my_masscan_cmd_smb}

	printf "\nHTTP Results:\n"
	awk '/tcp/ {print $4,$3 }' "$outfile_tmp" | sortip |\
	awk '{  seen[$1]=="" ? (seen[$1] = $2) : (seen[$1] = seen[$1] "," $2) } END { for (i in seen) print i "\t" seen[i] }' | sortip | tee "$outfile"

	rm -f "$outfile_tmp"
}

##############################################################################################################
# MY DOCKER STUFF
##############################################################################################################
# A work in progress... ;)





##############################################################################################################
# DOCKER FROM ROPNOP
##############################################################################################################
# From: https://blog.ropnop.com/docker-for-pentesters/


function dockershell() {
    docker run --rm -i -t --entrypoint=/bin/bash "$@"
}

function dockershellsh() {
    docker run --rm -i -t --entrypoint=/bin/sh "$@"
}

function dockershellhere() {
    dirname=${PWD##*/}
    docker run --rm -it --entrypoint=/bin/bash -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function dockershellshhere() {
    docker run --rm -it --entrypoint=/bin/sh -v `pwd`:/${dirname} -w /${dirname} "$@"
}

function dockerwindowshellhere() {
    dirname=${PWD##*/}
    docker -c 2019-box run --rm -it -v "C:${PWD}:C:/source" -w "C:/source" "$@"
}

impacket() {
    sudo docker run --rm -it rflathers/impacket "$@"
}

smbservehere() {
    local sharename
    [[ -z $1 ]] && sharename="SHARE" || sharename=$1
    sudo docker run --rm -it -p 445:445 -v "${PWD}:/tmp/serve" rflathers/impacket smbserver.py -smb2support $sharename /tmp/serve
}

# Need to disable smb2 support in some cases apparently
# JUST kidding! I  have no idea how stuff works.
#smbservehere2() {
#    local sharename
#    [[ -z $1 ]] && sharename="SHARE" || sharename=$1
#    sudo docker run --rm -it -p 445:445 -v "${PWD}:/tmp/serve" rflathers/impacket smbserver.py $sharename /tmp/serve
#}

nginxhere() {
    sudo docker run --rm -it -p 80:80 -p 443:443 -v "${PWD}:/srv/data" rflathers/nginxserve
}

cpscriptshere() {
	# Copy priv esc scripts into current folder
	cp -rf "/usr/share/windows-resources/" "./windows-resources/"
	cp -rf "/home/osboxes/Documents/win-privesc/" "./win-privesc/"
	cp -rf "/home/osboxes/Documents/lin-privesc/" "./lin-privesc/"
	rm "./windows-resources/nishang"
	cp -rf "/usr/share/nishang/" "./windows-resources/nishang"
}

webdavhere() {
    myoptions="-v \"${PWD}:/srv/data/share\""
    myoptions="$myoptions -v \"/usr/share/windows-resources/:/srv/data/winres\""
    myoptions="$myoptions -v \"/home/osboxes/Documents/win-privesc/:/srv/data/win-privesc\""
    myoptions="$myoptions -v \"/home/osboxes/Documents/lin-privesc:/srv/data/lin-privesc\""

    eval sudo docker run --rm -it -p 80:80 $myoptions rflathers/webdav
}

metasploit() {
    docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" metasploitframework/metasploit-framework ./msfconsole "$@"
}

metasploitports() {
    docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -p 8443-8500:8443-8500 metasploitframework/metasploit-framework ./msfconsole "$@"
}

msfvenomhere() {
    docker run --rm -it -v "${HOME}/.msf4:/home/msf/.msf4" -v "${PWD}:/data" metasploitframework/metasploit-framework ./msfvenom "$@"
}

reqdump() {
    docker run --rm -it -p 80:3000 rflathers/reqdump
}

postfiledumphere() {
    docker run --rm -it -p80:3000 -v "${PWD}:/data" rflathers/postfiledump
}





###############################################
# tmux commands

tmux set-buffer -b pyshell "python3 -c 'import pty; pty.spawn(\"/bin/bash\")'"
tmux set-buffer -b pyshell2 "python -c 'import pty; pty.spawn(\"/bin/bash\")'"
tmux set-buffer -b term "export TERM=xterm-256color"
tmux set-buffer -b stty "stty rows 49 columns 261"
tmux set-buffer -b path "export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
tmux set-buffer -b bashrc "$(cat ~/.bashrc)"
tmux set-buffer -b win-enable-rdp "reg add \"HKLM\System\CurrentControlSet\Control\Terminal Server\" /v fDenyTSConnections /t REG_DWORD /d 0 /f"
tmux set-buffer -b win-localgroup-adminadd "net localgroup administrators hacker2 /add"
tmux set-buffer -b win-useradd-STRONG "net user hacker2 SomePass11#! /add"
tmux set-buffer -b win-useradd-weak "net user hacker2 somepassword97 /add"
tmux set-buffer -b win-useradd-no-PW "net user hacker2 /add"
tmux set-buffer -b win-userlist "net user"
tmux set-buffer -b win-powershell-bypass "powershell -executionpolicy bypass -command \". \$pwd\\powerup.ps1\""


###############################################
# Need these below the PATH changes above.
# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump  # the -d option rebuilds the database every time
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion




