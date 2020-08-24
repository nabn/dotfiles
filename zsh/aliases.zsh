# General {{{
  alias ....='cd ..;cd ..;cd ..'
  alias ...='cd ..;cd ..'
  alias ..='cd ..'
  alias aliases="cat ~/.config/zsh/aliases.zsh | cut -d' ' -f 2-"
  alias chrome_canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'
  alias chrome_stable='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
  alias cl=clear
  alias cs='clear && git status'
  alias dark='base16_gruvbox-dark-medium'
  alias dirs=dirs\ -v
  alias du=ncdu
  alias f=fzf
  alias fb="buku -p -f 5 | column -ts$'\t' | fzf --multi"
  alias ft=fzf-tmux
  alias hosts='sudo nvim /etc/hosts'
  alias ivi='nvim' # common misspelling
  alias j=jobs
  alias light='base16_gruvbox-light-medium'
  alias ll='exa -lah'
  alias ls='exa -l --sort=newest'
  alias mux=tmuxinator
  alias pd='pushd; z '
  alias please='sudo $(fc -ln -1)'
  alias rg='rg --pretty --smart-case'
  alias rm='trash -v'
  alias s='sls --aws-profile bssdev2 --stage dev2'
  alias shop='open -n -a "Google Chrome" --args --profile-directory="Profile 2"'
  alias sonar-console='/opt/sonarqube/bin/macosx-universal-64/sonar.sh console'
  alias ssh='TERM=xterm-256color ssh'
  alias tmux='tmux -2'
  alias v='nvim `fzf`'
  alias vi='nvim'
  alias view='nvim -u NORC -R'
  alias watchstatus='while true; do clear; git status -s -b; sleep 5; done'
  alias za='nvim ~/.config/zsh/aliases.zsh'
  alias ze='nvim ~/.config/zsh/config.zsh'
  alias zreload='source ~/.config/zsh/config.zsh; source ~/.config/zsh/aliases.zsh'
  alias zt='zshz -l | fzf-tmux'
  alias restartbluetooth='blueutil -p 0 && sleep 3 && blueutil -p 1'
# }}}

# Suffix Aliases {{{
 alias -s md=vimr
 alias -s {cs,ts,html}=nvim
# }}}

# Utils {{{
  function changeBranchGrep {
    Remotes=`git branch -r`
    Locals=`git branch`
    Matches=`echo $Remotes$Locals\
      | grep -i $1\
      | sed 's|origin/||'\
      | tr -d '*'`

    echo $Matches | head -1 | xargs git checkout
  }

  function fbr() {
    local branches branch
    branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
    branch=$(echo "$branches" |
             fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  }


  watchstatus='while true; do clear; git status -s -b; sleep 5; done'

  function take {
    mkdir $1 && cd $1
  }

  function deploy {
    npm run deploy:"$1" &&\
      terminal-notifier -title "CSP deployment" -message "Deployment to $1 successful"
  }
  notifydone() {
    $1 && terminal-notifier -message 'done'
  }

# }}}

# Git {{{
  alias clone='git clone'
  alias copy-branch-name='git rev-parse --abbrev-ref HEAD | pbcopy'
  alias copy-ip-address='ifconfig | grep 192 | cut -d" " -f2 | pbcopy'
  alias g='git'
  alias ga='git add'
  alias gap='git add -p'
  alias gb='git --no-pager branch'
  alias gbd='git branch -d `git branch | fzf-tmux`'
  alias gbr='git branch -r'
  alias gc='git commit'
  alias gcd='git checkout `git branch | fzf-tmux`'
  alias gd='git diff'
  alias gdc="git diff --cached"
  alias get-ticket-number='git rev-parse --abbrev-ref HEAD | rg "^\w+-\d+" --only-matching --no-line-number'
  alias ggr=changeBranchGrep
  alias gl='git log --relative-date'
  alias glh='git log --relative-date -10'
  alias gp='git push'
  alias gpf='git push --force-with-lease'
  alias gpl='git pull'
  alias grba='git rebase --abort'
  alias grbc='git rebase --continue'
  alias grbi='git rebase -i'
  alias gs='git status'
  alias gsk='git stash --keep-index'
  alias gsp='git stash pop'
  alias syncmerge='git checkout master && git pull && git checkout - && git merge master'
  alias syncrebase='git checkout master && git pull && git checkout - && git rebase master'
  alias t='tig --no-merges'
  alias tm='tig --no-merges master...'
  alias tn='tig --no-merges --author=nabeen'
# }}}
