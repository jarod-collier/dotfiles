# Load user aliases if they exist
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

########################################################################
# Prompt
########################################################################

# Show the current Git branch in the prompt
export PS1='\u@\h:\w$(__git_ps1 " (%s)")\$ '

########################################################################
# General aliases
########################################################################

alias grep='grep --color=auto'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

alias rm='rm -I'
alias untar='tar -xf'

alias e='explorer'

alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'

########################################################################
# Navigation helpers
########################################################################

# Make a new directory and immediately enter it.
newdir() {
    mkdir -p -- "$1" &&
        cd -P -- "$1"
}
export newdir

# Navigate to homework folders.
# Example:
#   hw 3
# becomes:
#   ~/Desktop/CS/CSE842/collie89/Homework/HW3
hw() {
    cd ~/Desktop/CS/CSE842/collie89/Homework/HW"$1"
}
export hw

########################################################################
# Windows compatibility
########################################################################

# Git Bash didn't support man pages.
# This simply called "<command> --help".
man() {
    "$1" --help
}
export man

########################################################################
# Workspace aliases
########################################################################

alias ade='telnet 172.20.0.253 23'

alias dt='cd /c/DXL-Tools'
alias dtl='cd /c/DXL-Tools-LR'
alias kc='cd /c/KC46'
alias tc='cd /c/TC'

########################################################################
# ELM Team
########################################################################

# NOTE:
# The second alias overwrites the first one.
# Keep whichever one you actually want.

alias elm='cd /c/ELM'
alias elm='cd /c/ELM/avalm-central'

alias front='cd /c/ELM/avalm-central/frontend'
alias back='cd /c/ELM/avalm-central/backend'

alias runelm='cd /c/ELM/avalm-central/backend; pwd; echo "npm run build"; npm run build; cd /c/ELM/avalm-central/frontend; pwd; echo "npm run build"; npm run build; cd /c/ELM/avalm-central/backend; pwd; echo "node ."; node .'

alias buildelm='cd /c/ELM/avalm-central/backend; pwd; echo "npm run build"; npm run build; cd /c/ELM/avalm-central/frontend; pwd; echo "npm run build"; npm run build; cd /c/ELM/avalm-central/backend; pwd'

########################################################################
# Application shortcuts
########################################################################

alias c='code'
alias v='devenv'

alias f='find -iname'
alias p='python'

alias gitc='git checkout'

alias caf='~/caffeine/caffeine64.exe 300 -useshift &'

alias gs='git status'
alias ga.='git add .; gs'
alias gr.='git restore .; gs'
alias grs.='git restore --staged .; gs'

alias gitcam='gs; git commit -a -m'

########################################################################
# Visual Studio / VS Code helpers
########################################################################

# Find and open a file in VS Code.
cf() {
    c "$(f "$1")"
}
export cf

# Open another Git Bash instance.
newbash() {
    cd /c/Program\ Files/Git
    ./git-bash &
    cd -
}
export newbash

# Open Visual Studio in the background.
vs() {
    v "$1" &
}
export vs

# Change directory and open VS Code.
cdc() {
    cd "$1"
    c . &
}
export cdc

########################################################################
# DOORS
########################################################################

openDoors() {
    doors -d 36009@avewp0827v01.rd.ds.ge.com \
        -enabledTlsProtocols TLSV12 \
        -certdb /C/DXL-Tools/Naruto/servers/avewp0827v01 &
}
export openDoors

########################################################################
# Git helpers
########################################################################

gitla() {
    if [ "$2" != "" ]; then
        git log -n"$1" --author="$2"
    else
        git log -n"$1"
    fi
}
export gitla

gitlp() {
    if [ "$2" != "" ]; then
        git log -p -"${1}" --author="$2"
    else
        git log -p -"${1}"
    fi
}
export gitlp

gitloneline() {
    if [ "$2" != "" ]; then
        git log -n"$1" --author="$2" --pretty=oneline
    else
        git log -n"$1" --pretty=oneline
    fi
}
export gitloneline

gitls() {
    if [ "$2" != "" ]; then
        git log -n"$1" --author="$2" --stat
    else
        git log -n"$1" --stat
    fi
}
export gitls

gitcpp() {
    date
    gs
    ga.
    git commit -m "$1"
    git pull
    git push
    date
}
export gitcpp

# Tag a commit and push the tag.
#
# Usage:
#   gitTagPush v1.0.0 "Release version 1.0.0"

gitTagPush() {
    if [ $# -ne 2 ]; then
        echo "Usage: gitTagPush <tag-name> <tag-message>"
        return 1
    fi

    local tag_name=$1
    local tag_message=$2

    git tag -a "$tag_name" -m "$tag_message" || {
        echo "Failed to create tag: $tag_name"
        return 1
    }

    git push origin "$tag_name" || {
        echo "Failed to push tag: $tag_name"
        return 1
    }

    echo "Tag $tag_name created and pushed successfully!"
}
export gitTagPush

########################################################################
# Tree replacement (Git Bash)
########################################################################

# Git Bash didn't include tree.
#
# Options:
#   -d  Directories only
#   -f  Full path
#   -l  Exclude wildcard
#   -p  Omit directory
#   -t  Sort by modification time
#   -s  Show file sizes
#   -D  Show modification dates
#   -r  Reverse sort

tree() {
    cmd_command="cmd //c tree //a"

    for arg in "$@"; do
        cmd_command+=" //$arg"
    done

    $cmd_command
}
export tree

########################################################################
# File helpers
########################################################################

# Recursively list files while ignoring a folder.
# Defaults to ignoring node_modules.
lsr() {
    folder_to_ignore=${1:-node_modules}

    find . \
        -path "./$folder_to_ignore" -prune \
        -o -print
}
export lsr

# Delete files matching a pattern.
#
# Usage:
#   deleteFiles <directory> <pattern>
#
# Example:
#   deleteFiles . "*.log"

deleteFiles() {
    find "$1" -type f -name "$2" -exec rm -v {} +
}
export deleteFiles

########################################################################
# DXL helpers
########################################################################

# Create a directory for each .dxl file and move the file into it.
lsMkdirMv() {
    for f in *.dxl; do
        d="${f%.*}"

        mkdir -p "$d"
        mv -v "$f" "$d"
    done

    lsr
    echo "Done"
}
export lsMkdirMv

########################################################################
# Filename helpers
########################################################################

# Replace spaces with underscores for every file
# in the current directory.

swapSpaces() {
    for f in *\ *; do
        if [ -f "$f" ]; then
            new_name="${f// /_}"
            mv -- "$f" "$new_name"
        fi
    done
}
export swapSpaces
