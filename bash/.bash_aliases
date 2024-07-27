nv() {
  nvim "$1"
}

# Fuzzy finder
fdf() {
  local dir
  dir=$(find /home/$USER/Work -type d \( -path '*/.git' -prune -o -path '*/.git/*' -prune -o -path '*/node_modules' -prune -o -path '*/node_modules/*' -prune \) -o -print | fzf)
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

remix() {
  ~/Applications/Remix-Desktop-Insiders-1.0.7-insiders.AppImage --no-sandbox
}

lock() {
  i3lock -i /home/rohan/Pictures/lighthouse.png
}

dot() {
  local dir
  dir=$(find /home/$USER/.dotfiles -type d \( -path '*/.git' -prune -o -path '*/.git/*' -prune \) -o -print | fzf)
  if [[ -n "$dir" ]]; then
    cd "$dir" || return
  fi
}
