# tiny bash cheatsheet
# a=${VAR:-20} <- var or 20
# [ -z "$VAR" ] && 'this is false' || 'this is true'

function changeBranchGrep {
  Remotes=`git branch -r`
  Locals=`git branch`
  Matches=`echo $Remotes$Locals\
    | grep -i $1\
    | sed 's|origin/||'\
    | tr -d '*'`

  echo $Matches | head -1 | xargs git checkout
}

function take {
  mkdir $1 && cd $1
}

function v {
  fzf-tmux | xargs nvim
}
