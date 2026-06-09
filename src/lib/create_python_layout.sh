# SPDX-FileCopyrightText: 2026 tfoerst3r <32761865+tfoerst3r@users.noreply.github.com>
#
# SPDX-License-Identifier: MIT

## [@bashly-upgrade github:tfoerst3r/bash_helper_functions;create_code_base]

function create_python_layout { (

#================#
#== USER INPUT ==#
#================#

PROJECT_NAME="$1"
PACKAGE_NAME="$2"

#===============#
#== FUNCTIONS ==#
#===============#

function __main__ {
# __main__.py content
main_content="
from $PACKAGE_NAME.cli import cli as main

if __name__ ==\"__main__\":
  main()
"
echo "$main_content" > __main__.py
}

#---------------#

function cli {
# cli.py content
cli_content="
def cli():
    print('CLI call')
"
echo "$cli_content" > cli.py
}

#---------------#

function base {
# $PACKAGE_NAME.py content
base_content="

def __hidden() -> None:
    print('$PACKAGE_NAME call')


def $PACKAGE_NAME() -> None:
    __hidden()

"
echo "$base_content" > $PACKAGE_NAME.py
}

#---------------#

function __init__ {
# __init__.py content
init_content="
from $PACKAGE_NAME.$PACKAGE_NAME import (
    $PACKAGE_NAME, # noqa: F401
)
__all__ = ['$PACKAGE_NAME',]

"
echo "$init_content" >> __init__.py
}

function pytest {
# conftest.py content
conftest_content="import pytest"

# test_base.py content
test_content="
import pytest
from $PACKAGE_NAME.$PACKAGE_NAME import $PACKAGE_NAME

# --- Basic call ---

def test_${PACKAGE_NAME}_runs():
    \"\"\"Test that the function runs without raising an exception.\"\"\"
    $PACKAGE_NAME()

# --- Return value ---

def test_${PACKAGE_NAME}_returns_none():
    \"\"\"Test that the function returns None (no explicit return).\"\"\"
    result = $PACKAGE_NAME()
    assert result is None

# --- Exception handling ---

def test_${PACKAGE_NAME}_no_args():
    \"\"\"Test that the function raises no error when called without arguments.\"\"\"
    try:
        $PACKAGE_NAME()
    except TypeError as e:
        pytest.fail(f'Unexpected TypeError: {e}')

# --- Parametrize example (adapt once your function accepts arguments) ---

# @pytest.mark.parametrize('input,expected', [
#     ('foo', 'foo result'),
#     ('bar', 'bar result'),
# ])
# def test_${PACKAGE_NAME}_parametrized(input, expected):
#     assert $PACKAGE_NAME(input) == expected
"

echo "$conftest_content" > conftest.py
echo "$test_content"     > test_${PACKAGE_NAME}.py

}

#---------------#

function test_empty_var {
if [ -z "$PACKAGE_NAME" ] || [ -z "$PROJECT_NAME" ]; then
    echo "Please give at least the PROJECT_NAME and/or PACKAGE_NAME."
    exit 1
fi
}

#---------------#

function testing {
  test_empty_var
}

#---------------#

function main {

  poetry new "$PROJECT_NAME" --name "$PACKAGE_NAME"
  cd "$PROJECT_NAME"
  poetry config virtualenvs.in-project true --local
  poetry add ruff pytest --group dev
  cd src/$PACKAGE_NAME
  __main__  # function call
  cli       # function call
  base      # function call
  __init__  # function call
  cd ../../tests
  pytest
  cd ../..

}

#==========#
#== MAIN ==#
#==========#
testing
main

) }
