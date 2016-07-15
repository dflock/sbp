#! /usr/bin/env bash

if [[ -n "$SSH_CLIENT" ]]; then
  host_value="${USER}@${HOSTNAME}"
else
  host_value="${USER}"
fi

if [[ "$(id -u)" -eq 0 ]]; then
  host_color_fg="0"
  host_color_bg="1"
else
  host_color_fg="$settings_host_color_fg"
  host_color_bg="$settings_host_color_bg"
fi

pretty_print_segment "$host_color_fg" "$host_color_bg" " ${host_value} "
