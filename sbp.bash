#################################
#   Simple Bash Prompt (SBP)    #
#################################
config_file="${HOME}/.sbp"
_sbp_enabled=0
if [[ -f "$config_file" ]]; then
  # shellcheck source=helpers/imports.bash
  source "${sbp_path}"/helpers/imports.bash
  # shellcheck source=settings.default
  source "$config_file"
  _sbp_enabled=1
else
  echo "SimpleBashPrompt: ERROR"
  echo "SimpleBashPrompt: No config file found at: ${HOME}/.sbp"
  echo "SimpleBashPrompt: Please create one or run the install script"
fi

function _sbp_generate_segments() {
  local left_segment_color
  _sbp_prompt_left_value=
  _sbp_prompt_right_value=
  _sbp_prompt_current_color=
  _sbp_segment_sep_orientation=right

  for seg in "${_sbp_settings_segments_left[@]}"; do
    "_sbp_generate_${seg}_segment"
  done

  left_segment_color="${_sbp_prompt_current_color}"
  _sbp_prompt_current_color="${_sbp_filler_color_bg}"

  _sbp_segment_sep_orientation=left

  for seg in "${_sbp_settings_segments_right[@]}"; do
    "_sbp_generate_${seg}_segment"
  done

  _sbp_prompt_current_color="${left_segment_color}"
  _sbp_segment_sep_orientation=right
  _sbp_generate_filler_segment
}

function _sbp_perform_trigger_hooks() {
  for hook in "${_sbp_settings_hooks[@]}"; do
    "_sbp_trigger_${hook}_hook"
  done
}

function _sbp_set_prompt {
  _sbp_current_exec_result=$?
  _sbp_current_exec_value=$(HISTTIMEFORMAT='' history 1 | awk '{print $2}' | cut -c1-10 )

  if [[ "$_sbp_enabled" -eq 1 ]]; then
    _sbp_perform_trigger_hooks
    _sbp_generate_segments
    PS1="\n${_sbp_prompt_left_value}${_sbp_prompt_right_value}${_sbp_color_reset}\n$(_sbp_color_print_escaped "${_sbp_settings_prompt_ready_color}") ${_sbp_char_ready} ${_sbp_color_reset}"
  fi
}

[[ "$PROMPT_COMMAND" == *_sbp_set_prompt* ]] ||  export PROMPT_COMMAND="_sbp_set_prompt;$PROMPT_COMMAND"
