#! /usr/bin/env bash

function print_colorized() { # prints ansi escape codes for fg and bg (optional)
  local fg_code=$1
  local bg_code=$2
  local fg_escaped="${color_reset}"
  local bg_escaped="${color_reset}"
  [[ "$fg_code" -lt 0 ]] || fg_escaped="\[\e[38;5;${fg_code}m\]"
  [[ "$bg_code" -lt 0 ]] || bg_escaped="\[\e[48;5;${bg_code}m\]"

  printf '%s' "${fg_escaped}${bg_escaped}"
}

function pretty_print_segment() {
  local segment_color_fg="$1"
  local segment_color_bg="$2"
  local segment_value="$3"

  printf '%s' "$(print_colorized "$segment_color_fg" "$segment_color_bg")${segment_value}"
}

function pretty_print_seperator() {
  local from_color=$1
  local to_color=$2
  local direction=$3

  [[ -z "$from_color" ]] && return 0 # Can't make pretty_print_seperator without a previous pretty_print_segment

  case $direction in
    right)
      pretty_print_segment "$from_color" "$to_color" "$settings_char_segment"
    ;;
    left)
      pretty_print_segment "$to_color" "$from_color" "$settings_char_segrev"
      ;;
  esac
}

function get_current_bg_color() { # returns the last bg color code
  sed -nE 's/.*\\\[\\e\[([0-9]+;[0-9]+;)?([0-9]+)m\\\].*/\2/pg' <<< "$1"
}

function strip_escaped_colors() {
  sed -E 's/\\\[\\e\[([0-9]+;[0-9]+;)?[0-9]+m\\\]//g' <<< "$1"
}

export -f pretty_print_segment
export -f pretty_print_seperator
export -f print_colorized
