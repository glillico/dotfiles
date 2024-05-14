if [ -v SSH_CLIENT ] || [ -v SSH_TTY ]; then
  MYPROMPT=$'\n%F{yellow}[%(?.%F{green}.%F{red}?%?) %F{cyan}%n@%m %F{green}%*%f %F{blue}%3~%F{yellow}]%f%b'
else
  MYPROMPT=$'\n%F{yellow}[%(?.%F{green}.%F{red}?%?) %F{green}%*%f %F{blue}%3~%F{yellow}]%f%b'
fi
