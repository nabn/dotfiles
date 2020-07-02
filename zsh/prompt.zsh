#!/usr/bin/env zsh

# zsh-async is required:
#   https://github.com/mafredri/zsh-async
# source $PWD/async.zsh

async_init

# cache variable
typeset -Ag prompt_data

# section for dir
function prompt_dir() {
  echo '%3~'
}

# section for git branch
function prompt_git() {
  cd -q $1
  $(git rev-parse --is-inside-work-tree) || return
  echo '%F{yellow}'`git rev-parse --abbrev-ref HEAD`'%f%'
}

# refresh prompt with new data
prompt_refresh() {
  PROMPT="$prompt_data[prompt_dir] $prompt_data[prompt_git] > "
  # Redraw the prompt.
  zle && zle .reset-prompt
}

prompt_callback() {
  local job=$1 code=$2 output=$3 exec_time=$4
  prompt_data[$job]=$output
  prompt_refresh
}

# Start async worker
async_start_worker 'prompt' -n
# Register callback function for the workers completed jobs
async_register_callback 'prompt' prompt_callback

# start async jobs before cmd
prompt_precmd() {
  async_job 'prompt' prompt_dir
  async_job 'prompt' prompt_git $PWD # required
}

# Setup
zmodload zsh/zle
autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_precmd

PROMPT='> '
