#! /usr/bin/env bash

virtualenv_value="${VIRTUAL_ENV##*/}"
pyenv_value=$(pyenv local 2>/dev/null)
segment_value="${virtualenv_value}${pyenv_value}"

if [[ -n "$segment_value" ]]; then
  pretty_print_segment "$settings_python_virtual_env_fg" "$settings_python_virtual_env_bg" " ${segment_value} "
fi
