export PS1="\[\033[33m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " # changes the bash prompt to be colorized, and rearranges the prompt to be “username@hostname:cwd $”
export CLICOLOR=1 # enable command line colors
export LSCOLORS=gxfxbxdxcxegedabagacad # define colors for the ls command
alias ls='ls -GFh' # alias ls to include a few flags by default. -G colorizes output, -h makes sizes human readable, and -F throws a / after a directory, * after an executable, and a @ after a symlink, making it easier to quickly identify things in directory listings
