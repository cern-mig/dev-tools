Code Style
==========

The code must be PEP8 compliant (http://www.python.org/dev/peps/pep-0008/).
To install `pep8`:
```bash
pip install pep8
```
and then simply run the `pep8` command against the interested module:
```bash
pep8 module/
```

Code checker
============

It is very recommended to run static code analyzer like `pylint`,
you can find a `pylint` configuration file in this folder,
it is called `.pylintrc`.
You can either place `.pylintrc` in your home folder or in the module
folder, if you chose the latest you then have to pass the file to pylint:
```bash
pylint --rcfile=.pylintrc module/
```
otherwise simply run:
```bash
pylint module/
```

How to release a new version of the module
==========================================

To release a new version of the module please follow these steps:

- update version number and date in the `module/__init__.py` file
- update the `CHANGES` file with the relative version number and date if present
- `git commit -am "preparing for release X.X"`
- `git push`

You are now almost ready to release a new version of the module.

Packaging documentation: https://packaging.python.org/

Make sure you have a valid `.pypirc` file.

We use twine for PyPI upload: https://pypi.org/project/twine/

You can now proceed and release the package using the release script,
from the module's git root run the helper script provided:
```bash
sh path/to/release-python.sh
```

It will propose you the module name / version to be released,
if everything is as expected confirm and proceed with the release.
