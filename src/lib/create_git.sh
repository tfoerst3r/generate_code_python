# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT
## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;create_code_base]

function create_git { ( 
#==========#
#== INIT ==#
#==========#

#================#
#== USER INPUT ==#
#================#
PROJECT_NAME="$1"
GIT_REPO="$2"

#===============#
#== FUNCTIONS ==#
#===============#

#==========#
#== MAIN ==#
#==========#
function main {
  
  cd "$PROJECT_NAME"

  git init
  git add *
  git commit -m "Initial Commit"

if [[ -n "$GIT_REPO" ]]; then
  git remote add origin "$GIT_REPO"
  git push -u origin main
fi

}

main
) }
