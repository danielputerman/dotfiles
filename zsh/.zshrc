

# Bring in secrets if they exist
if [[ -s "$HOME/.zsecrets" ]]; then
    source "$HOME/.zsecrets"
fi


# -- NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


# -- RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# -- PYENV
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi


# -- JENV
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


# Make the shell Vim compatible
bindkey -v

# History search enhancements
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh  
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# -- FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden'


export GPG_TTY=$(tty)
export ANDROID_HOME=~/Library/Android/sdk/
export PATH="$HOME/.cargo/bin:$PATH"

