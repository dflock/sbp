function pretty_print_segment() {
  printf '%s' "${@}"
}

export -f pretty_print_segment

function test_that_we_get_full_path() {
  local result
  local wdir=${PWD/$HOME/\~}
  local paths=${wdir//\//  }
  export settings_path_max_length=50
  result=$("${sbp_path}/segments/path.bash" 0 0)
  assert_equals " $paths " "$result"
}
