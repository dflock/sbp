TMP_FOLDER="/tmp/bauta.$RANDOM"

function pretty_print_segment() {
  printf '%s' "${@}"
}

export -f pretty_print_segment

function setup() {
  mkdir -p "$TMP_FOLDER"
  cd "$TMP_FOLDER" || exit 1
  git init
  touch test
  git add test
  git config user.email "you@example.com"
  git config user.name "Your Name"
  git commit -am "Testing"
}

function cleanup() {
  rm -rf $TMP_FOLDER
}

function test_that_we_get_master_branch() {
  export settings_git_max_length=50
  result=$("${sbp_path}/segments/git.bash" 0 0)
  assert_equals ' master ' "$result"
}

function test_that_we_see_dirty_dir() {
  export settings_git_max_length=50
  touch "${TMP_FOLDER}/dirty"
  result=$("${sbp_path}/segments/git.bash" 0 0)
  assert_equals ' master ? ' "$result"
}

function test_that_we_abide_by_max_length() {
  export settings_git_max_length=5
  result=$("${sbp_path}/segments/git.bash" 0 0)
  assert_length "$result" 7 # add to for the padding
}
