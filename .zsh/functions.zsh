############
# Functions
############

function aae() {
  export VIRTUAL_ENV_DISABLE_PROMPT=YES
  source ~/Development/Python_VENVs/venv/bin/activate
  export PROMPT=${MYPROMPT}
}

function dae() {
  deactivate
  PROMPT=${MYPROMPT}
}

# Show contents of known_hosts file with line numbers
function knownls() {
  nl -b a ~/.ssh/known_hosts
}

# Delete a given line number in the known_hosts file
function knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}

# nf [-NUM] [COMMENTARY...] -- never forget last N commands
function nf() {
  local n=-5
  [[ "$1" = -<-> ]] && n=$1 && shift
  fc -lnt ": %Y-%m-%d %H:%M ${*/\%/%%} ;" $n | tee -a ~/.neverforget
}

# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [rockylinux8|almalinux9|debian10|debian11|ubuntu2204|etc.]
# Run on arm64 if getting errors: `export DOCKER_DEFAULT_PLATFORM=linux/amd64`
function dockrun() {
  docker run -it --rm glillico/docker-"${1:-ubuntu2204}"-ansible /bin/bash
}

# Enter a running Docker container.
function denter() {
  if [[ ! "$1" ]] ; then
    echo "You must supply a container ID or name."
    return 0
  fi

  docker exec -it $1 bash
  return 0
}

# Location aliases
typeset -gA G_DIRS=(
  dev      "$HOME/Development"
  dl       "$HOME/Downloads"
  docs     "$HOME/Documents"
  hlab     "$HOME/Development/homelab"
  homelab  "$HOME/Development/homelab"
  hub      "$HOME/Development/GitHub"
)
# Location descriptions
typeset -gA G_DIR_DESC=(
  dev      "Development projects"
  dl       "Downloads folder"
  docs     "Documents"
  hlab     "Homelab projects"
  homelab  "Homelab projects (alias)"
  hub      "GitHub repositories"
)
typeset -ga G_DIR_KEYS=(${(o)${(k)G_DIRS}})

# Change directory function
function g() {
  local action=""
  local input=""

  for arg in "$@"; do
    case "$arg" in
      -e) action=edit ;;
      -f) action=file ;;
      *) input="${arg%/}" ;;
    esac
  done

  if [[ -z "$input" || "$input" == "-h" || "$input" == "--help" ]]; then
    echo "Usage: g <location>[/subdirectory] [options] [-e]" 
    echo
    echo "Options:"
    echo "  -h, --help    Show help"
    echo "  -l, --list    List configured locations"
    echo "  -e            Open the location in VSCodium"
    echo "  -f            Open the location in Finder"
    return 0
  fi

  if [[ "$input" == "-l" || "$input" == "--list" ]]; then
    local key
    printf "%-10s %-30s %s\n" "Alias" "Description" "Location"
    printf "%-10s %-30s %s\n" "-----" "-----------" "--------"

    for key in $G_DIR_KEYS; do
      printf '%-10s %-30s %s\n' \
        "$key" \
        "${G_DIR_DESC[$key]}" \
        "${G_DIRS[$key]}"
    done
    return 0
  fi

  local key="${input%%/*}"
  local subpath="${input#*/}"
  local root="${G_DIRS[$key]}"
  local dest="$root"

  if [[ -z "$root" ]]; then
    echo "Unknown location: $key"
    echo "Available: ${(@j:, :)G_DIR_KEYS}"
    return 1
  fi

  [[ "$input" != "$key" ]] && dest="$root/$subpath"

  if [[ -d "$dest" ]]; then
    builtin cd -- "$dest"

    case "$action" in
      edit) code . ;;
      file) open . ;;
    esac
  else
    echo "Directory not found: $dest"
    return 1
  fi
}

# Tab completion
function _g_complete() {
  if [[ "$words[2]" == */* ]]; then
    local key="${words[2]%%/*}"
    local root="${G_DIRS[$key]}"

    if [[ -n "$root" ]]; then
      _path_files -/ -W "$root" -P "$key/"
    else
      return 1
    fi
  else
    compadd -S '/' -- $G_DIR_KEYS
  fi
}

compdef _g_complete g
