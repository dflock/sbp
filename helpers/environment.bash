function log_error() {
  local context="${BASH_SOURCE[1]}:${FUNCNAME[1]}"
  >&2 echo "${context}: ${*}"
}

function load_config() {
  config_dir="${HOME}/.config/sbp"
  config_file="${config_dir}/sbp.conf"
  default_config_file="${sbp_path}/helpers/defaults.bash"

  # Load the users settings if it exists
  if [[ -f "$config_file" ]]; then
    set -a
    # shellcheck source=/dev/null
    source "$config_file"
    set +a
  else
    set -a
    # shellcheck source=helpers/defaults.bash
    source "$default_config_file"
    set +a
    mkdir -p "$config_dir"
    cp "$default_config_file" "$config_file"
  fi
}

export -f log_error
