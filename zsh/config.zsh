# Paths {{{
  export PATH="$PATH:/usr/local/opt/openssl@1.1/bin"
  export PATH="$PATH:/usr/local/opt/ruby/bin"
  export PATH="$PATH:/usr/local/lib/ruby/gems/2.6.0/bin"
  export PATH="$PATH:/usr/local/opt/sqlite/bin"
  export PATH="$PATH:/usr/local/bin"
  export PATH="$PATH:$HOME/.cargo/bin"
  export PATH="$PATH:$HOME/.local/bin"
# }}}

# Plugins {{{
  zplugin light zdharma/fast-syntax-highlighting
  zplugin light zsh-users/zsh-autosuggestions
  zplugin light zsh-users/zsh-completions

  zplugin load agkozak/zsh-z
# }}}

# Setup {{{
  setopt appendhistory

  bindkey -v
  bindkey '' history-incremental-search-backward
  bindkey '' autosuggest-accept

  # case-insensitive completion
  # zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
  zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

  # The following lines were added by compinstall
  zstyle :compinstall filename '/Users/nabeen.khadka/.zshrc'
  autoload -Uz compinit
  compinit
  # End of lines added by compinstall

# }}}

# LESS {{{
  export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
  export LESS=" -R "
  export LESS=-Ri # case-insensitive search
# }}}

# Other Variables {{{
  HISTFILE=~/.zsh_history
  HISTSIZE=10000
  SAVEHIST=10000
  HISTTIMEFORMAT='%F %T '

  fpath=(/usr/local/share/zsh-completions $fpath)

  export EDITOR=nvim
  export REACT_EDITOR=nvim
  export MANPAGER="nvim -R -c 'filetype plugin on | set ft=man' -"

  export NNN_CONTEXT_COLORS=1234
  export NNN_COPIER=pbcopy
# }}}

# Android {{{
export GRADLE_HOME='/usr/local/opt/gradle'
export ANDROID_NDK_HOME='/usr/local/share/android-ndk'
export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'
export ANDROID_HOME='/usr/local/share/android-sdk'
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-12.0.2.jdk/Contents/Home
export PATH=$PATH:$GRADLE_HOME/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools/19.1.0
# }}}

# Prompt {{{
  zplugin light geometry-zsh/geometry
# }}}

export HTTP_PROXY='http://dev.arrianlg.studio'
