<!--
SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>

SPDX-License-Identifier: CC-BY-4.0
-->

<div align='center'>
  <h1>Python Project Bash Script</h1>
  <span style='font-size:32pt;'>
    Creates a default Python Project
  </span>
</div>

This Script generate a ready to publish template.

## About the Project (optional)

This script routine was develop to speedup python project publication.

## Getting Started

### Prerequisites

- reuse 3.3 or later
- poetry 2.3 or later
- bashly 1.3.8 or later

### Installation

Changing the default license holder and license contact by changing `default: tfoerst3r` and `default: *@*` to your contact informations.

``` bash
$ cat src/bashly.yml
name: generate_code_python
help: Generates a python code project
version: 0.1.0

args:
  - name: project_name
    required: true
    help: Name of the code project
  - name: package_name
    help: Name of the package

flags:
  - long: --holder
    help: Name of the license holder
    arg: lic_holder
    default: tfoerst3r
  - long: --email
    help: Email contect of license holder
    arg: lic_email
    default: 32761865+tfoerst3r@users.noreply.github.com
  - long: --git
    help: URL to a git repo 
    arg: git_repo
```

To create the bash script run:

```
$ bashly generate --upgrade
created ./generate_code_python
```

## Usage

Using the scripts help:

``` bash
$ bash generate_code_python --help
```

Example:

``` bash
$ bash generate_code_python cli cli_openai --git GIT_REPO_URL
```

The `GIT_REPO_URL` should be compatible with the git command: `git remote add origin $GIT_REPO_URL`.

## Contributing

We are accepting merge requests, bug reports, and feature requests.

## License

See `LICENSE.md` for more information.

