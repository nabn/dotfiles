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

  export ANDROID_HOME=/Users/$USER/Library/Android/sdk
  export EDITOR=nvim
  export REACT_EDITOR=nvim
  export LESS=-Ri # case-insensitive search in Less
# }}}

# Setup {{{
  setopt appendhistory
  set -o vi

  # enable Ctrl-R
  bindkey -v
  bindkey '^R' history-incremental-search-backward
# }}}

# Plugins {{{
  zplugin light zdharma/fast-syntax-highlighting
  zplugin light zsh-users/zsh-autosuggestions
  zplugin light tj/git-extras
  zplugin light geometry-zsh/geometry
  zplugin load agkozak/zsh-z
# }}}
