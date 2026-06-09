
#==========#
#== INIT ==#
#==========#
set -e # Exit if a command exits with a non-zero status.

PROJECT_NAME="${args[project_name]}"
PACKAGE_NAME="${args[package_name]}"
CODETYPE="python"
LIC_HOLDER="${args[--holder]}"
LIC_EMAIL="${args[--email]}"
GIT_REPO="${args[--git]}"

#===============#
#== FUNCTIONS ==#
#===============#
function update_variables {

if [[ -z "$PACKAGE_NAME" ]]; then
  PACKAGE_NAME="$PROJECT_NAME"
  declare "args[package_name]"="$PROJECT_NAME"
fi

}

#============#
#=== MAIN ===#
#============#

update_variables
create_python_layout "$PROJECT_NAME" "$PACKAGE_NAME"
create_readme "$PROJECT_NAME"
create_gitignore $CODETYPE
create_vscode_debugger $CODETYPE

#.. final creation step
create_license "$PROJECT_NAME" "$LIC_HOLDER" "$LIC_EMAIL"

#.. final project init step
create_git "$PROJECT_NAME" "$GIT_REPO"

