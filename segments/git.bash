#! /usr/bin/env bash

[[ -n "$(git rev-parse --git-dir 2> /dev/null)" ]] || exit 0
git_bin=$(type -p git)
git_prompt_helper="$(dirname "$git_bin")$(dirname "$(readlink "$git_bin")")/../etc/bash_completion.d/git-prompt.sh";

if [[ -f "$git_prompt_helper" ]]; then
  source "$git_prompt_helper"
  git_ps1="$(__git_ps1 '%s')"
  git_head=$(cut -d' ' -f1 <<< "$git_ps1")
  if [[ ! "$git_head" == "$git_ps1" ]]; then
    git_state=" $(cut -d' ' -f2- <<< "$git_ps1")"
  fi
else
  git_head=$(sed -e 's,.*/\(.*\),\1,' <(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null))
  [[ -z "$git_head" ]] && exit 0
  git_state=" $(git status --porcelain | sed -Ee 's/^(.M|M.|.R|R.) .*/\*/' -e 's/^(.A|A.) .*/\+/' -e 's/^(.D|D.) .*/\-/' | grep -oE '^(\*|\+|\?|\-)' | sort -u | tr -d '\n')"
fi

if [[ $(( ${#git_head} + ${#git_state} )) -gt "$settings_git_max_length" ]]; then
  git_head_room=$(( settings_git_max_length - ${#git_state} - 2))
  git_head="${git_head:0:$git_head_room}.."
fi
segment_value=" ${git_head}${git_state} "
pretty_print_segment "$settings_git_color_fg" "$settings_git_color_bg" "${segment_value//  / }"
