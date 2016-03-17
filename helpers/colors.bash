## Human readable names
_sbp_color_blue=31
_sbp_color_red=196
_sbp_color_white=15
_sbp_color_grey=244
_sbp_color_dgrey=238
_sbp_color_lgrey=250
_sbp_color_green=148
_sbp_color_dgreen=22
_sbp_color_pink=161
_sbp_color_orange=166
_sbp_color_empty=-1
_sbp_color_reset='\[\e[00m\]'

## Color functions
function _sbp_color_print_escaped() { # prints ansi escape codes for fg and bg (optional)
  local fg_code fg_escaped bg_code bg_escaped
  fg_code=$1
  bg_code=$2
  [[ "$fg_code" -lt 0 ]] || fg_escaped="\[\e[38;5;${fg_code}m\]"
  [[ "$bg_code" -lt 0 ]] || bg_escaped="\[\e[48;5;${bg_code}m\]"

  if [[ -z "$bg_escaped" ]]; then
    echo -e "${_sbp_color_reset}${fg_escaped}"
  elif [[ -z "$fg_escaped" ]]; then
    echo -e "${_sbp_color_reset}${bg_escaped}"
  else
    echo -e "${fg_escaped}${bg_escaped}"
  fi
}
