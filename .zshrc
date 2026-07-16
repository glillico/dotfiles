#####################
# Set arch variables
#####################
arch_platform="$(uname -s)"
arch_name="$(uname -m)"
PROMPT_DISTRO="√"

###########
# Homebrew
###########
# Set architecture-specific brew share path.
if [ ${arch_platform} = "Darwin" ]
then
# Only autoupdate homebrew once a week
  export HOMEBREW_AUTO_UPDATE_SECS=604800
  share_path="/opt/homebrew/share"
# else
#   echo "Unknown architecture: ${arch_name}"
fi

# Colour output on Mac OS
unset LSCOLORS
export CLICOLOR=1
# Removed due to breaking some command line scripting.
#export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Allow history search via up/down keys
if [ -f ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh ]
then
  source ${share_path}/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[OA' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OB' history-substring-search-down
fi

# Settings for history.
HISTORY_IGNORE="(ls|[bf]g|exit|reset|clear|history|nf|hist|history 0)"
HISTSIZE=50000
SAVEHIST=100000
HISTFILE=~/.zsh_history

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Allow prompt expansion
setopt PROMPT_SUBST

#########
# Docker
#########
# set default docker build to use --progress=plain
export BUILDKIT_PROGRESS=plain

[[ -f ~/.zsh/completions.zsh ]] && source ~/.zsh/completions.zsh
[[ -f ~/.zsh/aliases.zsh ]] && source ~/.zsh/aliases.zsh
[[ -f ~/.zsh/functions.zsh ]] && source ~/.zsh/functions.zsh
[[ -f ~/.zsh/git.zsh ]] && source ~/.zsh/git.zsh
[[ -f ~/.zsh/os_type.zsh ]] && source ~/.zsh/os_type.zsh

###########
# Set PATH
###########
if [ ${arch_platform} = "Darwin" ]
then
  export PATH=/opt/homebrew/bin:$PATH
fi

# Prompt
if [ -v TERM_PROGRAM ]; then
  if [ -f ~/.zsh/${TERM_PROGRAM}.zsh ]; then
    source ~/.zsh/${TERM_PROGRAM}.zsh
  else
    source ~/.zsh/Default-TERM_PROGRAM.zsh
  fi
else
  source ~/.zsh/NO-TERM_PROGRAM.zsh
fi  
PROMPT=${MYPROMPT}

####################### 
# Local customisations
#######################
[[ -f ~/.zsh/local.zsh ]] && source ~/.zsh/local.zsh
