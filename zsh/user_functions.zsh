path_rel_git_base() {
  base=$(git rev-parse --show-toplevel 2>/dev/null)
  rel_path=$(realpath --relative-to="$base" `pwd` 2>/dev/null)
  inside_git=$(git rev-parse --is-inside-work-tree 2>/dev/null)

  [ -n "$inside_git" ] && [ "$rel_path" != "." ] && echo "%F{yellow}$rel_path%f% " || echo $(geometry_path)
}


# Geometry TODO  {{{
geometry_todo() {
  todo=$(head -n1 $GEOMETRY_TODO 2>/dev/null)
  [[ -z "$todo" ]] && return
  ansi ${GEOMETRY_TODO_COLOR:=gray} $todo
}

todo() { echo $* >> $GEOMETRY_TODO }

todone() {
  finished=$(head -n1 $GEOMETRY_TODO 2>/dev/null)
  [[ -z "$finished" ]] && return
  \sed -ie '1d' $GEOMETRY_TODO
  echo $finished >> $GEOMETRY_TODONE
  echo finished $finished
}
# }}}
