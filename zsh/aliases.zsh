# General {{{
  alias aliases="cat ~/.config/zsh/aliases.zsh | cut -d' ' -f 2-"

  alias chrome_canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'
  alias chrome_stable='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
  alias shop='open -n -a "Google Chrome" --args --profile-directory="Profile 2"'
  alias cl=clear
  alias cs='clear && git status'
  alias dark='base16_gruvbox-dark-medium'
  alias dirs=dirs\ -v
  alias du=ncdu
  alias f=fzf
  alias ft=fzf-tmux
  alias ivi='nvim' # common misspelling
  alias j=jobs
  alias light='base16_gruvbox-light-medium'
  alias ll='exa -l'
  alias ls='exa'
  alias mux=tmuxinator
  alias please='sudo $(fc -ln -1)'
  alias rg='rg --pretty --smart-case'
  alias rm='trash -v'
  alias serve='python3 -m http.server 8080 --bind 0.0.0.0'
  alias sonar-console='/opt/sonarqube/bin/macosx-universal-64/sonar.sh console'
  alias tmux='tmux -2'
  alias tree=gtree
  alias v='nvim `fzf-tmux`'
  alias vi='nvim'
  alias view='nvim -u NORC -R'
  alias watchstatus='while true; do clear; git status -s -b; sleep 5; done'
  alias za='nvim ~/.config/zsh/aliases.zsh'
  alias ze='nvim ~/.config/zsh/config.zsh'
  alias zreload='source ~/.config/zsh/*.zsh'
  alias zt='zshz -l | fzf-tmux'

  alias ..='cd ..'
  alias ...='cd ..;cd ..'
  alias ....='cd ..;cd ..;cd ..'
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
  watchstatus='while true; do clear; git status -s -b; sleep 5; done'

  alias connect_vpn="osascript\
    -e 'tell Application \"Tunnelblick\"'\
    -e 'connect(get name of first configuration)'\
    -e 'end tell'"
  alias disconnect_vpn="osascript\
    -e 'tell Application \"Tunnelblick\"'\
    -e 'disconnect(get name of first configuration)'\
    -e 'end tell'"
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
