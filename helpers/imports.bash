# shellcheck source=helpers/segments.bash
source "$sbp_path"/helpers/segments.bash

# shellcheck source=helpers/colors.bash
source "$sbp_path"/helpers/colors.bash

# shellcheck source=helpers/settings.bash
source "$sbp_path"/helpers/settings.bash

# shellcheck source=hooks/alert.bash
source "$sbp_path"/hooks/alert.bash

# shellcheck source=hooks/timer.bash
source "$sbp_path"/hooks/timer.bash


# shellcheck source=segments/host.bash
source "$sbp_path"/segments/host.bash

# shellcheck source=segments/path.bash
source "$sbp_path"/segments/path.bash

# shellcheck source=segments/git.bash
source "$sbp_path"/segments/git.bash

# shellcheck source=segments/filler.bash
source "$sbp_path"/segments/filler.bash

# shellcheck source=segments/command.bash
source "$sbp_path"/segments/command.bash

# shellcheck source=segments/timestamp.bash
source "$sbp_path"/segments/timestamp.bash

# shellcheck source=segments/return_code.bash
source "$sbp_path"/segments/return_code.bash

# shellcheck source=segments/path_read_only.bash
source "$sbp_path"/segments/path_read_only.bash
