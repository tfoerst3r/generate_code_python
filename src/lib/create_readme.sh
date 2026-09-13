# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT
## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;create_code_base]

function create_readme { ( 

#==========#
#== INIT ==#
#==========#
PROJECT_NAME="$1"

README_FILE=(
  "<div align='center'>"
  "  <h1>Bash/Bashly Helper Functions</h1>"
  "  <p style='font-size:32pt;'>"
  "    General purpose Bash functions"
  "  </p>"
  "</div>"
  ""
  "> This section is a general description of the project."
  "> It outlines the project's goals, reflects its actual state, and explains specific use cases or properties."
  "> Here is also a good space for a showcase image or video."
  ""
  "## About the Project (optional)"
  ""
  "## Getting Started"
  ""
  "### Prerequisites"
  ""
  "> Which software does the user need to have installed to run your project?"
  "> Which knowledge should they possess? (Link to potential learning resources)"
  "> Does the user require any accounts/ access rights with third-party services?"
  ""
  "### Installation"
  ""
  "> (If applicable) add step-by-step instructions on how to install and run the project"
  ""
  "## Usage"
  ""
  "> How to use your project?"
  "> How to handle everyday use cases? --> this can also be done on a separate documentation page"
  ""
  "## Roadmap (optional)"
  ""
  "> Give a glimpse of features that are on the roadmap"
  ""
  "## Contributing (optional)"
  ""
  "> Put other information here, like where to get help and find more project-related information,"
  "> e.g., community forums, discord channels, Trello boards"
  ""
  "We are accepting merge requests, bug reports, and feature requests."
  "Please see the [CONTRIBUTING.md](CONTRIBUTING.md) for the complete guide."
  ""
  "## License"
  ""
  "See \`LICENSE.md\` for more information."
  ""
  "-----"
  ""
  "> There are many more sections that can be included here, like"
  ">"
  "> * Contributors"
  "> * Contact information"
  "> * FAQ"
)

#================#
#== USER INPUT ==#
#================#

#===============#
#== FUNCTIONS ==#
#===============#

#==========#
#== MAIN ==#
#==========#
function main { 
  
  cd "$PROJECT_NAME"
  echo "<==== README is written in $PROJECT_NAME/README.md ====>"
  printf "%s\n" "${README_FILE[@]}" > README.md
}

main

) }

