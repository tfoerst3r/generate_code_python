#!/usr/bin/env bash

# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT

## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;create_code_base]

#================#
#== USER INPUT ==#
#================#
# Name of standalone script
_target_sa="create_license"

#===============#
#== FUNCTIONS ==#
#===============#

#.. standalone only
function printhelp_lic {
cat <<-EOM

Generates the basic project folder structure for different applications.
Individual project script are stored under >> $HOME/bin/$SCRIPT_FOLDER/ <<

REQUIREMENTS:
  - reuse

USAGE: 
  create_license [OPTIONS] FILETYPE LICENSE [LIC_HOLDER] [LIC_EMAIL] [STYLE] 

EXAMPLES:
  create_license --help
  create_license sh MIT python

OPTIONS:

   -h   --help           print help message and exit
   -d   --default        default Name and Email is used

ARGUMENTS:
   FILETYPE   Which files you want to add a specific license to
   LICENSE    Which license you want to use, from reuse

DESCRIPTION: 
   
   A quick way to add license   
   See help of the sub-scripts for more informations
   
   example:

   $> project mkdocs --help.

EOM
}

#---------------#

function msg_lic() {
  local scrname=$(basename "$0")
  echo "$scrname: $1" >&2
}

#---------------#

function _argparser_lic {

  while [ -n "$1" ]; do
    case $1 in
      -h  | --help    ) printhelp_lic && exit 0 ;;
      -d  | --default ) _default_lic=1; shift 1 ;;
      -r  | --replace ) _replace_lic=1; shift 1 ;;
      -*              ) msg_lic "unknown option (ignored): $1" && exit 1 ;;
      --              ) shift; break ;;
      *               ) _args_lic="$@"; break ;;
    esac
  done

}

#---------------#

function find_files_for_lic {

  FILETYPE="$1"
  LICENSE="$2"
  LIC_HOLDER="$3"
  LIC_EMAIL="$4"
  STYLE="$5"
  
  if [[ -z "$STYLE" ]]; then
  
  find . \
    -path "./.venv" -prune \
    -o -name "*.$FILETYPE" \
    -exec reuse annotate \
      --copyright "$LIC_HOLDER <$LIC_EMAIL>" \
      --license "$LICENSE" \
      {} +
  
  else
  
  find . \
    -path "./.venv" -prune \
    -o -name "*.$FILETYPE" \
    -exec reuse annotate \
      --copyright "$LIC_HOLDER <$LIC_EMAIL>" \
      --license "$LICENSE" \
      --style "$STYLE" \
      {} +
  
  fi
}

#================#

function create_license { (

  #================#
  #== USER INPUT ==#
  #================#
  PROJECT_NAME="$1"
  LIC_HOLDER="$2"
  LIC_EMAIL="$3"
  
  license_file="## License

This work is licensed under multiple licenses:
- The data sets are licensed under [CC0-1.0](LICENSES/CC0-1.0.txt).
- The source code and the accompanying material are licensed under [MIT](LICENSES/MIT.txt).
- The documentation are licensed under [CC-BY-4.0](LICENSES/CC-BY-4.0.txt).
- Insignificant files are licensed under [CC0-1.0](LICENSES/CC0-1.0.txt).

Please see the individual files for more accurate information.

> **Hint:** We provided the copyright and license information in accordance to the [REUSE Specification 3.3](https://reuse.software/spec/).
"

  #---------------#

  function main {
    
    cd "$PROJECT_NAME"
    reuse download MIT CC-BY-4.0 CC0-1.0
    echo "$license_file" > LICENSE.md
    reuse annotate --copyright "$LIC_HOLDER <$LIC_EMAIL>" --license CC-BY-4.0 README.md
    reuse annotate --copyright "$LIC_HOLDER <$LIC_EMAIL>" --license CC0-1.0 LICENSE.md
    find_files_for_lic py MIT "$LIC_HOLDER" "$LIC_EMAIL"
    find_files_for_lic toml CC0-1.0 "$LIC_HOLDER" "$LIC_EMAIL"
    find_files_for_lic lock CC0-1.0 "$LIC_HOLDER" "$LIC_EMAIL"
    find_files_for_lic gitignore CC0-1.0 "$LIC_HOLDER" "$LIC_EMAIL" python
  
  }
  
  #==========#
  #== MAIN ==#
  #==========#
  main

) }

#=== STANDALONE PROCESS ===#
# if [[ "${BASH_SOURCE[0]}" == "${0}" ]] && ! declare -f initialize >/dev/null && ! declare -f run >/dev/null; then

if [[ "$(basename "${BASH_SOURCE[0]}")" == "$_target_sa"* ]]; then

    #================#
    #== USER INPUT ==#
    #================#
    DEFAULT_LIC_HOLDER="tfoerst3r"
    DEFAULT_LIC_EMAIL="32761865+tfoerst3r@users.noreply.github.com"
    _default_lic=0
    _replace_lic=0

    # Setting global variables for stand alone process
    _argparser_lic "$@"
    _args_lic_arr=($_args_lic)

    if [[ $_replace_lic == 1 ]]; then
        
        echo "--replace not implemented, yet!"
        #.. Should replace either holder or license or both, may be not a good idea, when doing accidentily
        #sed -i '/SPDX-/d' <file>
        #exit 0
    fi

    if [[ $_default_lic == 1 ]]; then
        
        
        FILETYPE="${_args_lic_arr[0]}"
        LICENSE="${_args_lic_arr[1]}"
        LIC_HOLDER="$DEFAULT_LIC_HOLDER"
        LIC_EMAIL="$DEFAULT_LIC_EMAIL"
        STYLE="${_args_lic_arr[2]}"

        find_files_for_lic $FILETYPE $LICENSE $DEFAULT_LIC_HOLDER $DEFAULT_LIC_EMAIL $STYLE

    else
        
        FILETYPE="${_args_lic_arr[0]}"
        LICENSE="${_args_lic_arr[1]}"
        LIC_HOLDER="${_args_lic_arr[2]}"
        LIC_EMAIL="${_args_lic_arr[3]}"
        STYLE="${_args_lic_arr[4]}"

        find_files_for_lic $FILETYPE $LICENSE $LIC_HOLDER $LIC_EMAIL $STYLE

    fi
fi

