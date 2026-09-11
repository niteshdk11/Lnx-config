# +++++++++++++++++++++++++++++++++++++++++
# Oh My Zsh
# +++++++++++++++++++++++++++++++++++++++++

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"

plugins=(git)

source "$ZSH/oh-my-zsh.sh"


# +++++++++++++++++++++++++++++++++++++++++
# Local binaries
# +++++++++++++++++++++++++++++++++++++++++

export PATH="$HOME/.local/bin:$PATH"

# Debian command compatibility
if command -v fdfind >/dev/null 2>&1; then
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

if command -v batcat >/dev/null 2>&1; then
    ln -sf "$(command -v batcat)" "$HOME/.local/bin/bat"
fi


# +++++++++++++++++++++++++++++++++++++++++
# Custom Scripts
# +++++++++++++++++++++++++++++++++++++++++

for script in ~/.scripts/*.sh; do
    if [[ -f "$script" ]]; then
        source "$script"
    fi
done


# +++++++++++++++++++++++++++++++++++++++++
# Python Virtual Environment
# +++++++++++++++++++++++++++++++++++++++++

function virtualenv_prompt_info() {
    [[ -n ${VIRTUAL_ENV} ]] || return
    echo "${ZSH_THEME_VIRTUALENV_PREFIX=[}${VIRTUAL_ENV:t:gs/%/%%}${ZSH_THEME_VIRTUALENV_SUFFIX=]}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=1


# +++++++++++++++++++++++++++++++++++++++++
# Editor
# +++++++++++++++++++++++++++++++++++++++++

export EDITOR="micro"


# +++++++++++++++++++++++++++++++++++++++++
# Yazi
# +++++++++++++++++++++++++++++++++++++++++

function fs() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd

    yazi "$@" --cwd-file="$tmp"

    if cwd="$(command cat -- "$tmp")" &&
       [[ -n "$cwd" ]] &&
       [[ "$cwd" != "$PWD" ]]; then
        builtin cd -- "$cwd"
    fi

    rm -f -- "$tmp"
}
