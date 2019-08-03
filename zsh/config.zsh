# Paths {{{
  export PATH="$PATH:/usr/local/bin"
  export PATH="$PATH:$HOME/.cargo/bin"
  export PATH="$PATH:$ANDROID_HOME/tools"
  export PATH="$PATH:$ANDROID_HOME/platform-tools"
  export PATH="$PATH:$ANDROID_HOME/emulator"
  export PATH="$PATH:$HOME/.local/bin"

  export PATH="$PATH:/usr/local/lib/ruby/gems/2.6.0/bin"
  export PATH="/usr/local/opt/ruby/bin:$PATH"
  export PATH="/usr/local/opt/sqlite/bin:$PATH"
# }}}

# Other Environment Variables {{{
  HISTFILE=~/.zsh_history
  HISTSIZE=10000
  SAVEHIST=10000
  HISTTIMEFORMAT='%F %T '

  fpath=(/usr/local/share/zsh-completions $fpath)

  export ANDROID_HOME=/Users/$USER/Library/Android/sdk
  export EDITOR=nvim
  export REACT_EDITOR=nvim
  export LESS=-Ri # case-insensitive search in Less
# }}}

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/nabeen.khadka/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Plugins {{{
  zplugin light zdharma/fast-syntax-highlighting
  zplugin light zsh-users/zsh-autosuggestions
  # zplugin light zsh-users/zsh-completions
  zplugin light geometry-zsh/geometry
  zplugin load agkozak/zsh-z
# }}}

# Setup {{{
  setopt appendhistory
  # setopt MENU_COMPLETE
  autoload -Uz compinit

  # enable Ctrl-R
  bindkey -v
  bindkey '^R' history-incremental-search-backward
  bindkey '' autosuggest-accept

  # export ZSH_AUTOSUGGEST_USE_ASYNC=1
  # case-insensitive completion
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# }}}

