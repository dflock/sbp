#! /usr/bin/env bash

return_code=$1
if (( return_code == -1 )); then
  return_code=0
fi

if [[ "$return_code" -ne 0 && "$return_code" -ne 130 ]]; then
  segment_value="${return_code}"
  pretty_print_segment "$settings_return_code_fg" "$settings_return_code_bg" " ${segment_value} "
fi
