set -x VISUAL nvim
set -x EDITOR "$VISUAL"
set -x LANG en_GB.UTF-8
# N - Node.js Version Manager
set -x N_PREFIX $HOME/n

# Go - Go Language
set -x GOPATH $HOME/go

# Mono - .NET Framework
set -x FrameworkPathOverride /Library/Frameworks/Mono.framework/Versions/5.4.1/lib/mono/4.5
set -x DOTNET_CLI_UI_LANGUAGE en

# PATH
set -x PATH $HOME/bin
set -x PATH $PATH $N_PREFIX/bin
set -x PATH $PATH $HOME/.vimpkg/bin
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH $HOME/.yarn/bin
set -x PATH $PATH $HOME/go/bin
set -x PATH $PATH $HOME/Library/Python/3.7/bin
set -x PATH $PATH /Library/Frameworks/Mono.framework/Versions/Current/Commands
set -x PATH $PATH /usr/local/Cellar/vim/8.1.0001/bin
set -x PATH $PATH /usr/local/opt/go/libexec/bin
set -x PATH $PATH /usr/local/share/dotnet
set -x PATH $PATH /usr/local/go/bin
set -x PATH $PATH /usr/local/bin
set -x PATH $PATH /usr/local/sbin
set -x PATH $PATH /usr/sbin
set -x PATH $PATH /usr/bin
set -x PATH $PATH /sbin
set -x PATH $PATH /bin

# Aliases
alias sz="pv -b > /dev/null"
alias pj="pbpaste | sed -E 's/new\ Date[(]([0-9]*)[)]/\"\1\"/g' | jq '.'"
alias hi="highlight"
alias listen="ncat -kl"
alias py=python3
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias elc="history | head -n 1 | vim"
alias k="kubectl --insecure-skip-tls-verify"

# Not shareable environment variables
if test -e ~/.config/fish/confidential_env.fish
    source ~/.config/fish/confidential_env.fish
end
