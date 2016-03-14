### Defaults
_sbp_git_color_bg=${_sbp_git_color_bg:-$_sbp_color_green}
_sbp_git_color_fg=${_sbp_git_color_fg:-$_sbp_color_dgrey}
_sbp_git_prompt_location=${_sbp_git_promt_location:-'/usr/share/git/completion/git-prompt.sh'}

function _sbp_generate_git_segment() {
  if [ -f "$_sbp_git_prompt_location" ]; then
    source "$_sbp_git_prompt_location"
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWUPSTREAM=1
    GIT_PS1_DESCRIBE_STYLE="branch"
    GIT_PS1_SHOWUPSTREAM="auto git"
    git_value=$(__git_ps1 '%s')
  else
    [[ -n "$(git rev-parse --git-dir 2> /dev/null)" ]] || return 0
    local git_head git_state git_value
    git_head=$(sed -e 's,.*/\(.*\),\1,' <(git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD))
    git_state=" $(git status --porcelain | sed -Ee 's/^(.M|M.|.R|R.) .*/\*/' -e 's/^(.A|A.) .*/\+/' -e 's/^(.D|D.) .*/\-/' | grep -oE '^(\*|\+|\?|\-)' | sort -u | tr -d '\n')"
    git_value="${git_head}${git_state}"
  fi

  _sbp_segment_new_color_fg="$_sbp_git_color_fg"
  _sbp_segment_new_color_bg="$_sbp_git_color_bg"
  _sbp_segment_new_length="$(( ${#git_value} + 0 ))"
  _sbp_segment_new_value=" ${git_value} "
  _sbp_segment_new_create
}


# git_value=''$git_value
