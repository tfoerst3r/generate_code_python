# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT

## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;vscode_debug]

function create_vscode_debugger { ( 

#================#
#== USER INPUT ==#
#================#
VSCODEFOLDER=".vscode"
CONFIGFILE="launch.json"
LANG="$1"
PROJECT_NAME="${args[project_name]}"

declare LAUNCHER[python]="{
    \"version\": \"2.0.0\",
    \"configurations\": [

        {
            \"name\": \"Python Debugger: Module\",
            \"type\": \"debugpy\",
            \"request\": \"launch\",
            \"module\": \"em\",
            \"args\": [],
            \"console\":\"integratedTerminal\"
        }
    ]
}
"

#==========#
#== MAIN ==#
#==========#
function main {
  cd "$PROJECT_NAME"
  if [[ -d "$VSCODEFOLDER" ]]; then
      cd "$VSCODEFOLDER"
  else
      mkdir "$VSCODEFOLDER" && cd "$VSCODEFOLDER"
  fi
  
  echo "<==== $CONFIGFILE is written in $VSCODEFOLDER ====>"
  echo "${LAUNCHER[$LANG]}" > "$CONFIGFILE"
}

main

) }
