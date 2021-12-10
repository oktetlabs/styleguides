# OKTET Labs python development guide

- [OKTET Labs python development guide](#oktet-labs-python-development-guide)
  - [Versions and dependencies](#versions-and-dependencies)
  - [Coding style](#coding-style)
  - [Formatters](#formatters)
    - [YAPF](#yapf)
    - [f-strings](#f-strings)
  - [Linters](#linters)
    - [pylint](#pylint)
    - [mypy](#mypy)
  - [Editors/configuration](#editorsconfiguration)
    - [VSCode](#vscode)
    - [VIM](#vim)
    - [Emacs](#emacs)
  - [Project scripting](#project-scripting)

## Versions and dependencies

Python version depends on the system you're targeting. Keep in mind that:

- you MUST NOT write new code for `python2.x`;
- RHEL7.4 which is default for some enterprises does not allow to install
  anything but 3.6;
- with the RHEL7 exception you MUST NOT rely on non-standard python
  interpreters, i.e. if target distro alloows `python3.9` you MUST NOT assume
  you will manage to install `python3.11` unless it's explicitly approved;
- you MUST NOT rely on packages that can't be installed via pip OR your distro
  (`apt/dnf/yum`) OR bundled with your scripts.

## Coding style

OL coding style is mostly equivalent to google
https://google.github.io/styleguide/pyguide.html with the exception that is
documented below in the yaml tool format.

yapf config+results have higher priority over whatever is written in the
standard. Running formatter on your formatted code should have zero diff.

## Formatters

### YAPF

We use yapf in it's default configuration. It's at least 0.30 and can be
installed via pip.

https://github.com/google/yapf is the tool.

We have slightly different config:

```text
[yapf]
align_closing_bracket_with_visual_indent = false
based_on_style = google
blank_line_before_nested_class_or_def = true
blank_lines_between_top_level_imports_and_variables = 2
coalesce_brackets = true
column_limit = 96
continuation_indent_width = 4
dedent_closing_brackets = false
force_multiline_dict = true
indent_closing_brackets = false
spaces_before_comment = 4
split_before_first_argument = false
split_before_logical_operator = true
split_complex_comprehension = true
```

### f-strings

Unless you know why you MUST use fstrings over `%-f` and `.format()`. You will
get complains from linters as well as your coleagues.

Note, that you can use:

`flynt`

tool (`pip install flynt`) to do your code conversion.

## Linters

### pylint

As we're using slightly modified google standard. Config file should allow basic
"good" short names.

```text
[BASIC]
# Good variable names w
good-names=k, kv, ex, e
```

otherwise you'll get warnings for code like

```python

for k, element in my_dict.items():
    print(f'{k}: {element})
```

or code (questionalble since we don't specify exact exception that we catch)

```python
try:
    foo()
except Exeption as e:
    print(f'got {e}')
    sys.exit(1)
```

### mypy

If writing on python3 you MUST use type annotation and you MUST have a clean
mypy run with the below config:

```text
[mypy]
check_untyped_defs = True
disallow_untyped_defs = True
disallow_incomplete_defs = True
disallow_untyped_decorators = True
disallow_any_unimported = True
warn_return_any = True
warn_unused_ignores = True
no_implicit_optional = True
show_error_codes = True
```

The `setup.cfg` file must be placed at the top level of your repo so all tools
see it and handle correctly. Invocation should include:

- `--follow-imports=silent`
- `--ignore-missing-imports`
- `--show-column-numbers`
- `--no-pretty`

`mypy` version to be used: at least 0.8. Can be installed from `pip` or
automatically by the IDE.

## Editors/configuration

### VSCode

```json
    "python.linting.mypyEnabled": true,
    "python.formatting.provider": "yapf",
    "python.linting.pylintEnabled": true,
```

### VIM

### Emacs

## Project scripting

Project should have:

- `setup.cfg` having the above config sections,
- `scripts/pyformat` and `scripts/pycheck` that are doing the right thing for
  those who want to invoke them by hands or for all patches in the patch series.

pyformat should apply all agreed formatters. pycheck should apply all agreed
linters.
