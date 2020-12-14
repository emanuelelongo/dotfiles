if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
  docker
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
)

export ZSH=$HOME/.oh-my-zsh
export REPOS=$HOME/repos
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANG=en_GB.UTF-8
setopt HIST_IGNORE_SPACE
# show PWD as tab name instead of process name
# (warning: some zsh theme doesn't work well with this configuration)
DISABLE_AUTO_TITLE="true"
function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}

# apply directory-specific .zsh_history
chpwd() {
  if test -f "${PWD}/.zsh_history" && [ $(dirname ${HISTFILE}) != ${PWD} ]; then
    export HISTFILE="${PWD}/.zsh_history"
    # -Pp reloads the history file (undocumented? Shouldn't be -R ?)
    fc -Pp "${PWD}/.zsh_history"

    echo "History context changed"
  fi
}

### KEY BINDINGS ###
# ALT + Left Arrow
bindkey "[D" backward-word
# ALT + Right Arrow
bindkey "[D" backward-word
bindkey "[C" forward-word

### ALIASES ###
alias sz="pv -b > /dev/null"
alias pj="pbpaste | sed -E 's/new\ Date[(]([0-9]*)[)]/\"\1\"/g' | jq '.'"
alias hi="highlight --out-format=xterm256"
alias listen="ncat -kl"
alias py=python3
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias k="kubectl"

### FUNCTIONS ###
function mkcd() { mkdir -p "$@" && cd "$_"; }

function myip() {
	ifconfig|grep netmask|awk '{print $2}';
	curl -s https://ip.seeip.org/
}

function github() {
	if [ $2 ]; then
		git clone https://github.com/$1/$2.git
		cd $1;
		return
	fi
	curl -s https://api.github.com/users/$1/repos | jq ".[].name" | tr -d '"'
}

function ric() {
    pbpaste | sed -e 's/'"$1"'/'"$2"'/g' | pbcopy
}

function gtree {
 	git_ignore_files=("$(git config --get core.excludesfile)" .gitignore ../.gitignore ../../.gitignore ../../../.gitignore ~/.gitignore)
 	ignore_pattern="$(grep -hvE '^$|^#' "${git_ignore_files[@]}" 2>/dev/null|tr '\n' '\|')"
 	if git status &> /dev/null && [[ -n "${ignore_pattern}" ]]; then
 		tree -I ".git|${ignore_pattern}" "${@}" -a
 	else
 		tree "${@}" -a
 	fi
}

function urlencode() { jq -sRr @uri }

function http_ok() {
    if [ "$#" -lt 1 ]; then
        echo "Create a simple http server that always return \"200 OK\" response\n"
        echo "Usage: http_ok <port> [response text]"
        return
    fi

    ncat -l -k -p $1 -c "echo HTTP/1.1 200 OK'\n\n'${2}'\n'" -o /dev/stdout
}

function http_raw() {

    if [ "$#" -lt 2 ]; then
        echo "Send raw http request\n"
        echo "Usage: raw_http <request_file> <endpoint> [port]"
        return
    fi
    (cat $1; sleep 1 ) | ncat $2 ${3:=80}
}

function http_raw_ssl() {
    if [ "$#" -lt 2 ]; then
        echo "Send raw http request through ssl\n"
        echo "Usage: http_raw_ssl <request_file> <endpoint> [port]"
        return
    fi
    (cat $1; sleep 1 ) | ncat --ssl $2 ${3:=443}
}

function http_poll() {
    if [ "$#" -ne 1 ]; then
        echo "Notify when an http endpoint becomes available\n"
        echo "Usage: http_poll <endpoint>"
        return
    fi

    while true; do
        output=$(http -h $1 --timeout=5 2>1 | grep HTTP/1.1 | awk {'print $2'})
        if [ "$output" -eq "200" ]; then
            osascript -e 'tell app "System Events" to display alert "'$1' is now available"'
            return
        fi
        sleep 60
    done
}

function http_forward() {
    if [ "$#" -ne 2 ]; then
      echo "Forward (and dump) http traffic from src_port to dest_port\n"
      echo "Usage: http_forward <src_port> <dest_port>"
      return
    fi
    mitmdump -v -p $1 -m reverse:http://localhost:$2
}

function auto_goseq() {
  echo $1 | entr -p -c goseq -o $1.svg $1
  # echo $1 | entr -p -c -s "goseq -o $1.svg $1 && osascript -e 'tell application \"Firefox\" to activate' -e 'tell application \"System Events\"' -e 'keystroke \"r\" using command down' -e 'end tell'"
}

function lucia() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: lucia <source folder> <file to append> <dest folder>"
    return
  fi

  src=$1
  append=$2
  dest=$3

  mkdir -p "$dest"
  i=0
  total=$(ls "$src"/*.pdf | wc -l | xargs)
  for f in "$src"/*.pdf; do
    i=$(( i + 1 ))
    out=$dest/$(basename -- "$f")
    "/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" -o "$out" "$f" "$append"
    echo -ne "$i"/"$total"'\r';
  done
}

### N - Node.js Version Manager ###
export N_PREFIX=$HOME/n

### PATH ###
export PATH=$HOME/bin
export PATH=$PATH:$N_PREFIX/bin
export PATH=$PATH:$HOME/.vimpkg/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:$HOME/Library/Python/3.7/bin
export PATH=$PATH:/usr/local/Cellar/vim/8.1.0001/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/usr/local/share/dotnet
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/flutter/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/bin

### FZF - Fuzzy Search ###
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


### SUGGESTION (zsh-users/zsh-autosuggestions)
# Temporary Fix: removed forward-char from list (pasting issue)
export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-forward-char vi-end-of-line vi-add-eol)
export ZSH_AUTOSUGGEST_STRATEGY=(history)

### Go - Go Language ###
export GOPATH=$HOME/go

### COMPLETIONS ###
# Completion for the dotnet CLI #
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet

# Completion for kubectl
source <(kubectl completion zsh)

### SHELL PROMPT ###
# powerlevel10k: to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/.p10k.zsh

