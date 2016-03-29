### Defaults
_sbp_path_color_bg=${_sbp_path_color_bg:-$_sbp_color_blue}
_sbp_path_color_fg=${_sbp_path_color_fg:-$_sbp_color_white}
_sbp_path_color_sep=${_sbp_path_color_sep:-$_sbp_color_grey}
_sbp_path_disable_sep=${_sbp_path_disable_sep:-0}
_sbp_path_max_length=${_sbp_path_max_length:-"30"}

function _sbp_generate_path_segment {
  local path_color sep_color sep wdir
  local path_value=
  wdir=${PWD/$HOME/\~}
  if [[ "${#wdir}" -gt "$_sbp_path_max_length" ]]; then
    wdir="$(dirname "${wdir}" | sed -e "s;\(/.\)[^/]*;\1;g")/$(basename "${wdir}")"
  fi

  IFS=/ read -r -a wdir_array <<<"$wdir"
  if [[ $_sbp_path_disable_sep -eq 0 && "${#wdir_array[@]}" -gt 1 ]]; then
    path_color=$(_sbp_color_print_escaped "$_sbp_path_color_fg" "$_sbp_path_color_bg")
    sep_color=$(_sbp_color_print_escaped "$_sbp_path_color_sep" "$_sbp_path_color_bg")
    sep=" ${sep_color}${_sbp_char_path}${path_color} "
    wdir_stripped=$(echo "${wdir}" | sed -E 's|^/||')
    path_value=" ${wdir_stripped//\//$sep}"
  else
    path_value=" $wdir"
  fi

 _sbp_segment_new_color_fg="$_sbp_path_color_fg"
 _sbp_segment_new_color_bg="$_sbp_path_color_bg"
 _sbp_segment_new_value="${path_color}${path_value} "
 _sbp_segment_new_create
}
