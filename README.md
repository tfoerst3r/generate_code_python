!--
SPDX-FileCopyrightText: 2026 Thomas Förster <noreply@tfoerster.de>

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

Changing the default license holder and license contact by changing `default: Max Musterman` and `default: *@*` to your contact informations.

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

### Generating the Python Project

Using the scripts help:

``` bash
$ bash generate_code_python --help
```

>[!EXAMPLE]
> 
>~~~ bash
>bash generate_code_python cli cli_openai --git GIT_REPO_URL
>~~~
>
> The `GIT_REPO_URL` should be compatible with the git command: `git remote add origin $GIT_REPO_URL`.
>
> What happens?: 
> - Python packages `ruff` and `pytest` are installed.
> - All files are licenced and licenses are downloaded
> - git repo is created
> - base structure for start working on *CLI*, *Module*, *Library* is created
>
>~~~bash
>Created package cli_openai in cli
>Creating virtualenv cli-openai in /home/tfoerst/sandbox/pytt/cli/.venv
>Using version ^0.16.7 for ruff
>Using version ^9.1.1 for pytest
>
>...
>Installing the current project: cli-openai (0.1.0)
><==== README is written in cli/README.md ====>
><==== .gitignore is written ====>
><==== launch.json is written in .vscode ====>
><==== tasks.json is written in .vscode ====>
>...
>~~~

### Initial Python Project 

Based on the given example the project has now the following structure:

```bash
cli/
├── LICENSE.md
├── LICENSES
│   ├── CC0-1.0.txt
│   ├── CC-BY-4.0.txt
│   └── MIT.txt
├── poetry.lock
├── poetry.lock.license
├── poetry.toml
├── pyproject.toml
├── README.md
├── src
│   └── cli_openai
│       ├── cli.py
│       ├── __init__.py
│       ├── __main__.py
│       └── util.py
└── tests
    ├── conftest.py
    ├── __init__.py
    └── test_cli_openai.py
```

**Library:** the following python code would work.

```python
from cli_openai.util import foo
foo()
```

Module: you can execute the module.

```bash
poetry run python -m cli_openai
```

CLI: using the command line interface `cli_openai`.

```bash
poetry run cli_openai
```


## Contributing

We are accepting merge requests, bug reports, and feature requests.

## License

See `LICENSE.md` for more information.

