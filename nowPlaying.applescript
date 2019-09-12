tell application "Spotify"
  set current to current track
  return "[\"" & (name of current track) & "\", \"" & (artist of current track) & "\", \"" & (artwork url of current track) & "\"]"
end tell
