#!/bin/sh
# Ghostty's initial-command: pick a recent directory from zoxide with fzf
# (arrows, type to filter, Enter opens it, Esc opens ~), then exec a login zsh there.

# Ghostty may start without the Homebrew PATH
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH

# Ghostty only injects its zsh integration when it runs zsh itself; do it here
if [ -n "$GHOSTTY_RESOURCES_DIR" ] && [ -d "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh" ]; then
  integration="$GHOSTTY_RESOURCES_DIR/shell-integration/zsh"
  if [ "$ZDOTDIR" != "$integration" ]; then
    [ -n "${ZDOTDIR+x}" ] && export GHOSTTY_ZSH_ZDOTDIR="$ZDOTDIR"
    export ZDOTDIR="$integration"
  fi
fi

dir="$HOME"
if command -v zoxide >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
  recent=$(zoxide query -l 2>/dev/null)
  if [ -n "$recent" ]; then
    picked=$(printf '%s\n' "$recent" | fzf --reverse --tiebreak=index --prompt='cd ' --header='Enter: open  Esc: ~')
    [ -n "$picked" ] && [ -d "$picked" ] && dir="$picked"
  fi
fi

cd "$dir" 2>/dev/null || cd "$HOME"
exec /bin/zsh -l
