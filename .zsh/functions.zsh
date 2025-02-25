############
# Functions
############

function aae() {
  source ~/Development/Python_VENVs/venv/bin/activate
  PROMPT=${MYPROMPT}
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
