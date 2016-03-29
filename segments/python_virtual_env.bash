### Defaults
_sbp_python_virtual_env_bg=${_sbp_python_virtual_env_bg:-$_sbp_color_dgreen}
_sbp_python_virtual_env_fg=${_sbp_python_virtual_env_fg:-$_sbp_color_white}

function _sbp_generate_python_virtual_env_segment() {
  local pyenv_value segment_value segment_value
  virtualenv_value="${VIRTUAL_ENV##*/}"
  pyenv_value=$(pyenv local 2>/dev/null)
  segment_value="${virtualenv_value}${pyenv_value}"

  if [[ -n "$segment_value" ]]; then
    _sbp_segment_new_color_bg="$_sbp_python_virtual_env_bg"
    _sbp_segment_new_color_fg="$_sbp_python_virtual_env_fg"
    _sbp_segment_new_value=" ${segment_value} "
    _sbp_segment_new_create
  fi
}
