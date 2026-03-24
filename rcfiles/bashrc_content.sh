# My custom bashrc settings

# Environment variables
export EDITOR='nvim'

set completion-ignore-case on

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Modified Commands
alias pip=pip3
alias xclip='xclip -selection c'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias top='btop'
alias lsl='ls -l'
alias n='nvim'
alias update='sudo apt update -y && sudo apt full-upgrade -y'

# Safety check for lsd
if command -v lsd &> /dev/null; then
    alias ls='lsd'
else
    alias ls='ls --color=auto'
fi

# git shortcuts
alias g='git'
alias gcam='git commit -a -m'
alias gpl='git pull'
alias gps='git push'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Search command line history
alias h="history | grep "

# Whats the time
alias da='date "+%Y-%m-%d %A %T %Z"'

# Search running processes
alias p='ps aux | grep '
alias topcpu='/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'

# Search files in the current folder
alias f='find . | grep '

# Count all files (recursively) in the current folder
alias countfiles='for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# zoxide shortcut
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

# alias to cleanup unused docker containers, images, networks, and volumes
alias docker-clean='docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f '


#######################################################
# SPECIAL FUNCTIONS
#######################################################
# Extracts any archive(s) (if unp isn't installed)
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Searches for text in all files in the current folder
ftext() {
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar (using rsync)
cpp() {
    rsync -ah --progress "$1" "$2"
}


# Automatically do an ls after each cd, z, or zoxide (Interactive only)
cd ()
{
    if [[ $- == *i* ]]; then
        if [ -n "$1" ]; then
            builtin cd "$@" && ls
        else
            builtin cd ~ && ls
        fi
    else
        builtin cd "$@"
    fi
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip () {
    # Internal IP Lookup.
    echo -n "Internal IP: "
    ip route get 1.1.1.1 | awk '{print $7; exit}'

    # External IP Lookup
    echo -n "External IP: "
    curl -s ifconfig.me
    echo ""
}
