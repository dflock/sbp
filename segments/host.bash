### Defaults
_sbp_host_color_bg=${_sbp_host_color_bg:-$_sbp_color_dgrey}
_sbp_host_color_fg=${_sbp_host_color_fg:-$_sbp_color_lgrey}

function _sbp_generate_host_segment {
  local host_value
  if [[ -n "$SSH_CLIENT" ]]; then
    host_value="${USER}@${HOSTNAME}"
  else
    host_value="${USER}"
  fi

  if [[ "$(id -u)" -eq 0 ]]; then
    _sbp_segment_new_color_fg="0"
    _sbp_segment_new_color_bg="1"
  else
    _sbp_segment_new_color_fg="$_sbp_host_color_fg"
    _sbp_segment_new_color_bg="$_sbp_host_color_bg"
  fi
  _sbp_segment_new_value=" ${host_value} "
  _sbp_segment_new_length="$(( ${#host_value} + 2 ))"
  _sbp_segment_new_create
}
