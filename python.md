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
- you MUST NOT rely on packages that can't be installed via `pip` OR your distro
  (`apt/dnf/yum`) OR bundled with your scripts;
- you SHOULD use `python -m pip install` instead of simply `pip install`,
  where `python` is certain Python interpreter version you intend to use.

## Coding style

OL coding style is mostly equivalent to google
https://google.github.io/styleguide/pyguide.html with the exception that is
documented below in the yaml tool format.

yapf config+results have higher priority over whatever is written in the
standard. Running formatter on your formatted code should have zero diff.

## Formatters

### YAPF

We use yapf in it's default configuration. It's at least 0.30 and can be
installed via `pip`.

https://github.com/google/yapf is the tool.

We have slightly different config:

- look for table **\[yapf\]** at [setup.cfg](./python/setup.cfg);
- or look for table **\[tool.yapf\]** at [pyproject.toml](./python/pyproject.toml)

### f-strings

Unless you know why you MUST use fstrings over `%-f` and `.format()`. You will
get complains from linters as well as your coleagues.

Note, that you can use:

`flynt`

tool (`pip install flynt`) to do your code conversion.

## Linters

### pylint

Please take this config [pylintrc](./python/pylintrc) and place it into `.pylintrc`.

### mypy

If writing on python3 you MUST use type annotation and you MUST have a clean
mypy run with the below config:

- look for table **\[mypy\]** at [setup.cfg](./python/setup.cfg);
- or look for table **\[tool.mypy\]** at [pyproject.toml](./python/pyproject.toml)

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

Usually VSCode project config file is `.vscode/settings.json`.

```json
    "python.linting.mypyEnabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "yapf",
    "python.formatting.yapfArgs": [
        "--style",
        "{based_on_style = google, ...}"
    ],
    "editor.formatOnSave": true
```

Note that `yapfArgs` must contain all YAPF style settings described above.

### VIM

### Emacs

## Project scripting

Project should have:

- [setup.cfg](./python/setup.cfg) or [pyproject.toml](./python/pyproject.toml)
  having the above config sections,
- `scripts/pyformat` and `scripts/pycheck` that are doing the right thing for
  those who want to invoke them by hands or for all patches in the patch series.

pyformat should apply all agreed formatters. pycheck should apply all agreed
linters.
