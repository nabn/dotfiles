# Added by Zinit's installer {{{ 
  if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
      print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
      command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
      command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
          print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
          print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi

  source "$HOME/.zinit/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit

  # Load a few important annexes, without Turbo
  # (this is currently required for annexes)
  zinit light-mode for \
      zinit-zsh/z-a-patch-dl \
      zinit-zsh/z-a-as-monitor \
      zinit-zsh/z-a-bin-gem-node

  autoload -Uz compinit
  if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit
  else
    compinit -C
  fi
# }}} End of Zinit's installer chunk

# Plugins {{{
zinit load agkozak/zsh-z
zinit load geometry-zsh/geometry
zinit load zsh-users/zsh-autosuggestions
zinit load zdharma/fast-syntax-highlighting
zinit load mafredri/zsh-async
zinit load tj/git-extras
zinit load Aloxaf/fzf-tab
# }}}

# Prompt {{{
GEOMETRY_PROMPT=(geometry_status geometry_path geometry_echo geometry_jobs )
GEOMETRY_RPROMPT+=(geometry_todo)
GEOMETRY_TODO_COLOR=red
# # }}}

# Setup {{{
setopt appendhistory
# https://stackoverflow.com/a/19819036/824944
setopt aliases
setopt NO_NOMATCH

bindkey -v
export KEYTIMEOUT=1 # remove 0.4 second delay after <ESC> key
bindkey '' history-incremental-search-backward
bindkey '' autosuggest-accept

# case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

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

export NNN_CONTEXT_COLORS=3241
export NNN_COPIER=pbcopy

# less
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R"
export LESS=-Ri # case-insensitive search

# make homebrew auto-update every day instead of the default of every minute
export HOMEBREW_AUTO_UPDATE_SECS=86400

# Italics for vim-deux colorscheme
export TERM_ITALICS=true
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
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="$HOME/Library/Python/2.7/bin:$PATH"


export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
# }}}

# Node version manager: fnm {{{
  eval "$(fnm env --multi)"
# }}}

# NNN :- Terminal file browser {{{
  n ()
  {
      # Block nesting of nnn in subshells
      if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
          echo "nnn is already running"
          return
      fi

      # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
      # To cd on quit only on ^G, remove the "export" as in:
      #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
      # NOTE: NNN_TMPFILE is fixed, should not be modified
      # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

      # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
      # stty start undef
      # stty stop undef
      # stty lwrap undef
      # stty lnext undef

      nnn "$@"

      if [ -f "$NNN_TMPFILE" ]; then
              . "$NNN_TMPFILE"
              rm -f "$NNN_TMPFILE" > /dev/null
      fi
  }
# }}}

# Geometry todo {{{
  # geometry_todo - simple stack of todo items

  export GEOMETRY_TODO=${GEOMETRY_TODO:-${HOME}/.todo.md}
  export GEOMETRY_TODONE=${GEOMETRY_TODONE:-${HOME}/.todone.md}
  touch $GEOMETRY_TODO $GEOMETRY_TODONE
# }}}
