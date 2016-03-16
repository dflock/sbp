### Defaults
_sbp_path_color_readonly_fg=${_sbp_path_color_readonly_fg:-$_sbp_color_white}
_sbp_path_color_readonly_bg=${_sbp_path_color_readonly_bg:-$_sbp_color_red}

function _sbp_generate_path_read_only_segment {
  if [[ ! -w "$PWD" ]] ; then
    local command_value

    command_value=""

    _sbp_segment_new_color_bg="$_sbp_path_color_readonly_bg"
    _sbp_segment_new_color_fg="$_sbp_path_color_readonly_fg"
    _sbp_segment_new_length="3"
    _sbp_segment_new_value=" ${command_value} "
    _sbp_segment_new_create
  fi
}
