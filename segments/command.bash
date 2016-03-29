### Defaults
_sbp_command_color_fg=${_sbp_command_color_fg:-$_sbp_color_dgrey}
_sbp_command_color_fg_fail=${_sbp_command_color_fg_fail:-$_sbp_color_lgrey}
_sbp_command_color_bg_fail=${_sbp_command_color_fail:-$_sbp_color_red}
_sbp_command_color_bg_success=${_sbp_command_color_bg_success:-$_sbp_color_lgrey}

function _sbp_generate_command_segment {
  local command_value command_color_fg
  if [[ "$_sbp_current_exec_result" -eq 0 || "$_sbp_current_exec_result" -eq 130 ]]; then
    _sbp_command_color_bg="$_sbp_command_color_bg_success"
    command_color_fg="$_sbp_command_color_fg"
  else
    _sbp_command_color_bg="$_sbp_command_color_bg_fail"
    command_color_fg="$_sbp_command_color_fg_fail"
  fi

  command_value="last: ${_sbp_timer_m}m ${_sbp_timer_s}s"

  _sbp_segment_new_color_fg="$command_color_fg"
  _sbp_segment_new_color_bg="$_sbp_command_color_bg"
  _sbp_segment_new_value=" ${command_value} "
  _sbp_segment_new_create
}
