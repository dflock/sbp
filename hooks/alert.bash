#! /usr/bin/env bash

settings_alert_threshold="${settings_alert_hook:-60}"

function alert_exec() { # User notification
  [[ -z "$2" ]] && return

  title=$1
  message=$2

  if type terminal-notifier &> /dev/null; then
    (terminal-notifier -title "$title" -message "$message" &)
  elif [[ "$(uname -s)" == "Darwin" ]]; then
    osascript -e "display notification \"$message\" with title \"$title\""
  elif type notify-send &> /dev/null; then
    (notify-send "$title" "$message" &)
  fi
}

function trigger_alert_hook {
  local exit_code=$1
  local command_time=$2

  [[ "$exit_code" -lt 0 ]] && return
  if [[ "$settings_alert_threshold" -le "$command_time" ]]; then
    local title message

    if [[ "$exit_code" -eq "0" ]]; then
      title="Command Succeded"
      message="Time spent was ${command_time}s"
    else
      title="Command Failed"
      message="Time spent was ${command_time}s"
    fi

    alert_exec "$title" "$message"
  fi
}
trigger_alert_hook "$1" "$2"
