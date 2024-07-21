# Fuzzy finder
fdf() {
  local dir
  dir=$(find /home/$USER/Work | fzf)
  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}

neo4j-desktop() {
  ~/Applications/neo4j-desktop.AppImage --no-sandbox
}

obsidian() {
  ~/Applications/Obsidian-1.6.5.AppImage --no-sandbox
}

lock() {
  i3lock -i /home/rohan/Pictures/lighthouse.png
}

dot() {
  local dir
  dir=$(find /home/$USER/.dotfiles | fzf)
  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}
