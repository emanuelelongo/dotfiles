export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#aliases
alias sz="pv -b > /dev/null"
alias pj="pbpaste | sed -E 's/new\ Date[(]([0-9]*)[)]/\"\1\"/g' | jq '.'"
# Custom functions
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

# PATH
export PATH=$PATH:$HOME/.vimpkg/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:/Library/Frameworks/Mono.framework/Versions/Current/Commands
export PATH=$PATH:/usr/local/Cellar/vim/8.1.0001/bin
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/usr/local/share/dotnet
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/sbin
export PATH=$PATH:/bin

# this is shell for autocompletion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# N - Node.Js Version Manager
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  

# Mono - .NET Framework
export FrameworkPathOverride=/Library/Frameworks/Mono.framework/Versions/5.4.1/lib/mono/4.5

# FZF - Fuzzy Search 
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'head -100 {}'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Go - Go Language
export GOPATH=$HOME/go
