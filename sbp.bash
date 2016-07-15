#################################
#   Simple Bash Prompt (SBP)    #
#################################
_sbp_previous_history_id=
export sbp_path
#shellcheck source=helpers/cli.bash
source "${sbp_path}/helpers/cli.bash"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  date_cmd='date'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  date_cmd='gdate'
else
  # Unknown.
  date_cmd='gdate'
fi

function _sbp_timer_start() {
  timer_start=$("$date_cmd" +'%s%3N')
}

function _sbp_timer_tick() {
  timer_stop=$("$date_cmd" +'%s%3N')
  timer_spent=$(( timer_stop - timer_start))
  >&2 echo "${timer_spent}ms: $1"
  timer_start=$("$date_cmd" +'%s%3N')
}


function _sbp_set_prompt {
  local command_exit_code=$?
  [[ -n "$SBP_DEBUG" ]] &&_sbp_timer_start
  local last_history command_started command_ended command_time last_history_id
  command_ended=$(date +'%s')
  last_history=$(HISTTIMEFORMAT='%s ' history 1)
  command_started=$(cut -d ' ' -f 4 <<< "$last_history")
  command_time=$(( command_ended - command_started ))
  last_history_id=$(cut -d ' ' -f 2 <<< "$last_history")
  unset last_history

  if [[ -z "$_sbp_previous_history_id" || "$_sbp_previous_history_id" -eq "$last_history_id" ]]; then
    command_exit_code=-1
    command_time=-1
  fi

  _sbp_previous_history_id=$last_history_id

  PS1=$("${sbp_path}/helpers/prompt.bash" "$COLUMNS" "$command_exit_code" "$command_time")
  [[ -n "$SBP_DEBUG" ]] &&_sbp_timer_tick "Done"
}

[[ "$PROMPT_COMMAND" =~ _sbp_set_prompt ]] || export PROMPT_COMMAND="_sbp_set_prompt;$PROMPT_COMMAND"
