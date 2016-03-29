### Defaults
_sbp_filler_color_bg=${_sbp_filler_color_bg:-$_sbp_color_reset}
_sbp_filler_color_fg=${_sbp_filler_color_fg:-$_sbp_color_reset}

function _sbp_generate_filler_segment {
  local all_segments all_characters resulting_length
  all_segments="${_sbp_prompt_left_value}${_sbp_prompt_right_value} ${sep_value}"
  all_characters=$(echo -e "${all_segments}" | perl -pe 's/\x1b\[[0-9;]*m//g' |  sed -e 's/\\e\[00m//g' -e 's/\\\[\\\]//g')
  resulting_length=${#all_characters}

  spaces=$(printf "%*s" $(( COLUMNS - resulting_length )) )

  _sbp_segment_new_color_fg="$_sbp_filler_color_fg"
  _sbp_segment_new_color_bg="$_sbp_filler_color_bg"
  _sbp_segment_new_value="${spaces}"
  _sbp_segment_new_create
}
