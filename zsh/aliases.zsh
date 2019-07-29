alias aliases="cat ~/.config/zsh/aliases.zsh | cut -d' ' -f 2-"

alias chrome_canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'
alias chrome_stable='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias cl=clear
alias cs='clear && git status'
alias dark='base16_gruvbox-dark-medium'
alias du=ncdu
alias j=jobs
alias light='base16_gruvbox-light-medium'
alias ll='ls -l'
alias ls='lsd'
alias mux=tmuxinator
alias rg='rg --pretty --smart-case'
alias rm='trash -v'
alias serve='python3 -m http.server 8080 --bind 0.0.0.0'
alias sonar-console='/opt/sonarqube/bin/macosx-universal-64/sonar.sh console'
alias tmux='tmux -2'
alias vi='nvim'
alias view='nvim -u NORC -R'
alias watchstatus='while true; do clear; git status -s -b; sleep 5; done'
alias za='nvim ~/.config/zsh/aliases.zsh'
alias ze='nvim ~/.config/zsh/config.zsh'
alias zr='source ~/.config/zsh/*.zsh'

alias ..='cd ..'
alias ...='cd ..;cd ..'
alias ....='cd ..;cd ..;cd ..'

watchstatus='while true; do clear; git status -s -b; sleep 5; done'

# Git aliases {{{
  function changeBranchGrep {
    Remotes=`git branch -r`
    Locals=`git branch`
    Matches=`echo $Remotes$Locals\
      | grep -i $1\
      | sed 's|origin/||'\
      | tr -d '*'`

    echo $Matches | head -1 | xargs git checkout
  }

  alias clone='git clone'
  alias copygitbranchname=git rev-parse --abbrev-ref HEAD | pbcopy
  alias g='git'
  alias ga='git add'
  alias gap='git add -p'
  alias gb='git --no-pager branch'
  alias gc='git commit'
  alias gd='git diff'
  alias gdc="git diff --cached"
  alias ggr=changeBranchGrep
  alias gl='git log --relative-date'
  alias glh='git --no-pager log --relative-date -10'
  alias gp='git push'
  alias gpf='git push --force-with-lease'
  alias gpl='git pull'
  alias gs='git status'
  alias t='tig --no-merges'
  alias tn='tig --no-merges --author=nabeen'
# }}}
