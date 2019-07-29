fpath+=${ZDOTDIR:-~}/.zsh_functions

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='
(git ls-tree -r --name-only HEAD ||
  find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
  sed s/^..//) 2> /dev/null'

  # Use fd (https://github.com/sharkdp/fd) instead of the default find
  # command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
      }

  # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
