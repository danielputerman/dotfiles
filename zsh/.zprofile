# -- (UNUSED) .PROFILE 
# Load profile settings from .profile
#[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile


# Editors 
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# -- LESS
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
export LESS='-g -i -M -R -S -w -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
