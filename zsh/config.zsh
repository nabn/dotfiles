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
zinit load zsh-users/zsh-autosuggestions
zinit load zdharma/fast-syntax-highlighting
zinit load mafredri/zsh-async
zinit load tj/git-extras
zinit load Aloxaf/fzf-tab
zinit load geometry-zsh/geometry
# }}}

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

# Prompt {{{
# export GEOMETRY_STATUS_SYMBOL="λ"
GEOMETRY_PROMPT=(geometry_status geometry_path geometry_echo geometry_jobs )
GEOMETRY_STATUS_SYMBOL="▲ "
GEOMETRY_STATUS_SYMBOL_ERROR="△ "
GEOMETRY_PATH_SHOW_BASENAME=true
# # }}}

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

export JAVA_HOME=`/usr/libexec/java_home`
# }}}

# Node version manager: nvm {{{
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # place this after nvm initialization!
  # autoload -U add-zsh-hook
  # load-nvmrc() {
  #   local node_version="$(nvm version)"
  #   local nvmrc_path="$(nvm_find_nvmrc)"
  #
  #   if [ -n "$nvmrc_path" ]; then
  #     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
  #
  #     if [ "$nvmrc_node_version" = "N/A" ]; then
  #       nvm install
  #     elif [ "$nvmrc_node_version" != "$node_version" ]; then
  #       nvm use
  #     fi
  #   elif [ "$node_version" != "$(nvm version default)" ]; then
  #     echo "Reverting to nvm default version"
  #     nvm use default
  #   fi
  # }
  # add-zsh-hook chpwd load-nvmrc
  # load-nvmrc
# }}}

# Paths {{{
# export PATH="/usr/local/lib/ruby/gems/5.7.0/bin:$PATH"
export PATH="/Users/nabeen/.gem/ruby/2.7.0/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
# export PATH=$HOME/.local/bin:$PATH
# # }}}

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
