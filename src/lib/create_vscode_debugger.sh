# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT

## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;vscode_debug]

function create_vscode_debugger { ( 

#================#
#== USER INPUT ==#
#================#
LANG="$1"
PACKAGE_NAME="$2"
VSCODEFOLDER=".vscode"
CONFIGFILE="launch.json"
TASKFILE="tasks.json"
PROJECT_NAME="${args[project_name]}"

#===============#
#== FUNCTIONS ==#
#===============#

declare TASKS[python]="{
    \"version\": \"2.0.0\",
    \"tasks\": [
        {
            \"label\": \"run_poetry_install\",
            \"type\": \"shell\",
            \"command\": \"poetry install\",
            \"presentation\": {
                \"reveal\": \"always\",
                \"panel\": \"shared\"
            },
            \"problemMatcher\": []
        }
    ]
}
"

#---------------#

declare LAUNCHER[python]="{
    \"version\": \"2.0.0\",
    \"configurations\": [

        {
            \"name\": \"Python Debugger: Module\",
            \"type\": \"debugpy\",
            \"request\": \"launch\",
            \"module\": \"$PACKAGE_NAME\",
            \"args\": [],
            \"console\":\"integratedTerminal\",
            \"preLaunchTask\": \"run_poetry_install\"
        }
    ]
}
"

#---------------#

function test_empty_var {
if [ -z "$PACKAGE_NAME" ] || [ -z "$LANG" ] ; then
    echo "Please add a PACKAGE_NAME or a programming LANGUAGE."
    exit 1
fi
}

#---------------#

function testing {
  test_empty_var
}

#---------------#

function main {
  cd "$PROJECT_NAME"
  if [[ -d "$VSCODEFOLDER" ]]; then
      cd "$VSCODEFOLDER"
  else
      mkdir "$VSCODEFOLDER" && cd "$VSCODEFOLDER"
  fi
  
  echo "<==== $CONFIGFILE is written in $VSCODEFOLDER ====>"
  echo "${LAUNCHER[$LANG]}" > "$CONFIGFILE"
  echo "<==== $TASKFILE is written in $VSCODEFOLDER ====>"
  echo "${TASKS[$LANG]}" > "$TASKFILE"
}

#==========#
#== MAIN ==#
#==========#
testing
main

) }
