if [ -v SSH_CLIENT ] || [ -v SSH_TTY ]; then
  MYPROMPT=$'\n%F{yellow}[%F{green}%n@%m %*%f %F{blue}%3~%F{yellow}]%f%b'$'\n%# '
else
  MYPROMPT=$'\n%F{yellow}[%F{green} %*%f %F{blue}%3~%F{yellow}]%f%b'$'\n%# '
fi
