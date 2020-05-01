# Plugins {{{
source ~/.zinit/bin/zinit.zsh
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light tj/git-extras
zinit light urbainvaes/fzf-marks

zinit load urbainvaes/fzf-marks

zinit load agkozak/zsh-z
zinit load andrewferrier/fzf-z

zinit load geometry-zsh/geometry

zinit light Aloxaf/fzf-tab
# }}}

# Prompt{{{
GEOMETRY_PATH_SHOW_BASENAME=true
GEOMETRY_PROMPT=(geometry_status geometry_path geometry_echo geometry_jobs )
# }}}

# Setup {{{
setopt appendhistory
# https://stackoverflow.com/a/19819036/824944
setopt aliases

bindkey -v
bindkey '' history-incremental-search-backward
bindkey '' autosuggest-accept

# case-insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/nabeen.khadka/.zshrc'
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
# End of lines added by compinstall

# without this, commands starting with `man` are slow
unset 'FAST_HIGHLIGHT[chroma-whatis]' 'FAST_HIGHLIGHT[chroma-man]'

# }}}

# Variables {{{
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT='%F %T '

fpath=(/usr/local/share/zsh-completions $fpath)
fpath+=${ZDOTDIR:-~}/.zsh_functions

export EDITOR=nvim
export REACT_EDITOR=nvim
export MANPAGER="nvim -c 'set ft=man' -"

export NNN_CONTEXT_COLORS=1234
export NNN_COPIER=pbcopy

# less
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R"
export LESS=-Ri # case-insensitive search

# make homebrew auto-update every day instead of the default of every minute
export HOMEBREW_AUTO_UPDATE_SECS=86400
# }}}

# Android {{{
export GRADLE_HOME='/usr/local/opt/gradle'
# export ANDROID_NDK_HOME='/usr/local/share/android-ndk'
# export ANDROID_SDK_ROOT='/usr/local/share/android-sdk'
# export ANDROID_HOME='/usr/local/share/android-sdk'
export ANDROID_HOME='/Users/nabeen.khadka/Library/Android/sdk'
export PATH=$PATH:$GRADLE_HOME/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/build-tools/19.1.0
# }}}

# Paths {{{
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"

export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# export PATH="$HOME/Library/Python/3.7/bin:$PATH"
# }}}

# homebrew flag logs {{{
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
# export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
# export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"


# Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
# `python3`, `python3-config`, `pip3` etc., respectively, have been installed into
#   /usr/local/opt/python/libexec/bin
# }}}

# fnm
eval "$(fnm env --multi)"
