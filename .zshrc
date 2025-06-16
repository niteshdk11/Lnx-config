# +++++++++++++++++++++++++++++++++++++++++
# Path to your Oh My Zsh installation.
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME_RANDOM_CANDIDATES=( "norm" "junkfood" "jtriley" "jonathan" "itchy" )

ZSH_THEME="amuse"

source "$ZSH/oh-my-zsh.sh" 

plugins=(git)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Import all scripts from /root/.scripts
for script in ~/.scripts/*.sh; do
  if [[ -f "$script" ]]; then
    source "$script"
  fi
done

eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null




# ---- LANGUAGES CONFIGURATION ----

# Color codes for output messages
RED='\033[0;31m'      # Red color
VIOLET='\033[0;35m'   # Violet (dark purple) color
BLUE='\033[0;34m'     # Blue color
PINK='\033[1;35m'     # Pink color
NC='\033[0m'          # No color (reset)


# Function to run Python scripts with nodemon
function runpy() {
  nodemon --exec "$HOME/.run_with_clear.sh" -- "${PINK}Python script is running on ADMIN${NC}" python3 "$@"
}

# Function to run Node.js scripts with nodemon
function runjs() {
  nodemon --exec "$HOME/.run_with_clear.sh" -- "${RED}JS script is running on ADMIN${NC}" node "$@"
}

# Function to compile and run Java programs with nodemon
function runjava() {
  nodemon --exec "$HOME/.run_with_clear.sh" -- "${VIOLET}Java program is running on ADMIN${NC}" java "$1"
}

# Function to compile and run C++ programs with nodemon
function runcpp() {
  nodemon --ext cpp --exec "$HOME/.run_with_clear.sh" -- "${BLUE}C++ program is running on ADMIN${NC}" "g++ $1 -o ${1%.cpp} && ./${1%.cpp}"
}

# this is for virtual env of python
function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "${ZSH_THEME_VIRTUALENV_PREFIX=[}${VIRTUAL_ENV:t:gs/%/%%}${ZSH_THEME_VIRTUALENV_SUFFIX=]}"
}

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1


export EDITOR="micro"

function fs() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

figlet "Welcome, Nitesh-dk!" | lolcat
