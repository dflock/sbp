### Defaults
_sbp_git_color_clean_bg=${_sbp_repo_color_clean_bg:-$_sbp_color_green}
_sbp_git_color_clean_fg=${_sbp_repo_color_clean_fg:-$_sbp_color_dgrey}
_sbp_git_color_dirty_bg=${_sbp_repo_color_dirty_bg:-$_sbp_color_pink}
_sbp_git_color_dirty_fg=${_sbp_repo_color_dirty_fg:-$_sbp_color_white}
_sbp_git_max_length=${_sbp_git_max_length:-"20"}

function _sbp_generate_git_segment() {
  [[ -n "$(git rev-parse --git-dir 2> /dev/null)" ]] || return 0
  local git_head git_state git_value
  if type __git_ps1 &>/dev/null; then
    git_value=" $(__git_ps1 '%s') "
  else
    git_head=$(sed -e 's,.*/\(.*\),\1,' <(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD))
    git_state=" $(git status --porcelain | sed -Ee 's/^(.M|M.|.R|R.) .*/\*/' -e 's/^(.A|A.) .*/\+/' -e 's/^(.D|D.) .*/\-/' | grep -oE '^(\*|\+|\?|\-)' | sort -u | tr -d '\n')"
    git_value=" ${git_head}${git_state} "
  fi

    if [[ ! -z "${git_value// }" ]]; then
      regex='\>|\<|\*|\+'
      if [[ $git_value =~ $regex ]]; then
        color_fg=$_sbp_git_color_dirty_fg
        color_bg=$_sbp_git_color_dirty_bg
      fi

      git_value=' '$git_value
      output_seg=1
    fi

  _sbp_segment_new_color_fg="$_sbp_git_color_fg"
  _sbp_segment_new_color_bg="$_sbp_git_color_bg"
  if [[ "${#git_value}" -gt "$_sbp_git_max_length" ]]; then
    _sbp_segment_new_value=$(echo "${git_value}" | sed "s/^\(.\{${_sbp_git_max_length}\}\).* \(.*\)/\1.. \2/" )
  else
    _sbp_segment_new_value=$git_value
  fi
  _sbp_segment_new_create
}
