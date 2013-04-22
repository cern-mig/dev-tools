Code Style
==========

The code must be PEP8 compliant (http://www.python.org/dev/peps/pep-0008/).

How to release a new version of the module
==========================================

To release a new version of the module please follow these steps:

- update version number and date in the `module/__init__.py` file
- update the `CHANGES` file with the relative version number and date if present
- `git commit -am "preparing for release X.X"`
- `git push`

You are now almost ready to release a new version of the module.

Make sure you read the pypi guide:
http://wiki.python.org/moin/CheeseShopTutorial#Submitting_Packages_to_the_Package_Index

and do not forget to set the `.pypirc` file (http://docs.python.org/2/distutils/packageindex.html#pypirc).

You can now proceed and release the package using the release script:
```
sh release.sh
```
