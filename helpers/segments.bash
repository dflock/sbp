_sbp_powerline_disable_file="$HOME/.sbp_powerline_disable"

if [[ -f "$_sbp_powerline_disable_file" ]]; then
  _sbp_char_segment=" "
  _sbp_char_path="/"
  _sbp_char_ready=">"
  _sbp_char_segrev=" "
else
  _sbp_char_segment=''
  _sbp_char_path=''
  _sbp_char_ready='➜'
  _sbp_char_segrev=''
fi

function _sbp_segment_append_sep() {
  if [[ -n "$_sbp_prompt_left_value" ]]; then
    local sep_color sep_value
    if [[ "$_sbp_segment_sep_orientation" = "right" ]]; then
      sep_color=$(_sbp_color_print_escaped "$_sbp_prompt_current_color" "$_sbp_segment_new_color_bg")
      sep_value="${sep_color}${_sbp_char_segment}"
      _sbp_prompt_left_value="${_sbp_prompt_left_value}${sep_value}"
    else
      sep_color=$(_sbp_color_print_escaped "$_sbp_segment_new_color_bg" "$_sbp_prompt_current_color")
      sep_value="${sep_color}${_sbp_char_segrev}"
      _sbp_prompt_right_value="${_sbp_prompt_right_value}${sep_value}"
    fi
  fi
}

function _sbp_segment_new_create() {
  local all_segments all_characters resulting_length
  all_segments="${_sbp_prompt_left_value}${_sbp_prompt_right_value}${_sbp_segment_new_value} ${sep_value}"
  all_characters=$(echo -e "${all_segments}" | perl -pe 's/\x1b\[[0-9;]*m//g' |  sed -e 's/\\e\[00m//g' -e 's/\\\[\\\]//g')
  resulting_length=${#all_characters}

  if [[ "$COLUMNS" -ge "$resulting_length" ]]; then
    _sbp_segment_append_sep
    _sbp_segment_new_color=$(_sbp_color_print_escaped "$_sbp_segment_new_color_fg" "$_sbp_segment_new_color_bg")

    if [[ "$_sbp_segment_sep_orientation" == "right" ]]; then
      _sbp_prompt_left_value="${_sbp_prompt_left_value}${_sbp_segment_new_color}${_sbp_segment_new_value}"
    else
      _sbp_prompt_right_value="${_sbp_prompt_right_value}${_sbp_segment_new_color}${_sbp_segment_new_value}"
    fi
    _sbp_prompt_current_color="${_sbp_segment_new_color_bg}"
  else
    echo "Skipping segment due to resulting length: $resulting_length"
  fi
}
