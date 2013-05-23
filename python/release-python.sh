#! /bin/sh

PACKAGE_NAME=`basename ${PWD}` || { echo "error getting the package nam"; exit 1; }
[ "x${PACKAGE_NAME}" == "x" ] && { echo "could not find a valid package name"; exit 1; }
NAME="${PACKAGE_NAME#python-}"
NAME=${NAME/-/.}
[ "x${PACKAGE_NAME}" == "x" ] && { echo "error getting the module name"; exit 1; }

echo "package name detected: ${PACKAGE_NAME}"
echo "python module detected: ${NAME}"

VERSION=`python <<DELIM
import ${NAME}
print(${NAME}.__version__)
DELIM` || { echo "error getting module ${PACKAGE_NAME} version"; exit 1; }

[ "x${VERSION}" == "x" ] && { echo "could not find a valid version"; exit 1; }

echo "going to release ${PACKAGE_NAME}-${VERSION}"
read -p "do you want to proceed with the release? (y/n) " RESP
if [ "x$RESP" == "xy" ]; then
    echo "continuing"
else
    echo "quitting"
    exit 1
fi

TAGNAME="v${VERSION}"
TAGEXISTS=`git tag -l | grep "^${TAGNAME}"`
if [ "${TAGEXISTS}x" == "x" ]; then
  echo "tagging current version with tag: ${TAGNAME}"
  git tag ${TAGNAME}
else
  echo "
error: tag ${TAGNAME} already exists
if you want to recreate it, delete it first:
    # remove local tag
    git tag -d ${TAGNAME}
    # to remove it remotely
    git push origin :refs/tags/${TAGNAME}"
    read -p "do you want to proceed with the current tag? (y/n) " RESP
    if [ "x$RESP" == "xy" ]; then
        echo "continuing"
    else
        echo "quitting"
        exit 1
    fi
fi

echo "pushing tag remotely"
git push --tags

TMPDIR=`mktemp -d /tmp/${PACKAGE_NAME}.XXXXXX` || exit 1
echo "temporary folder created: ${TMPDIR}"

pushd ${TMPDIR}

# cloning git repository to make sure that
# local files which are not versioned are not included
git clone git://github.com/cern-mig/${PACKAGE_NAME}.git
pushd ${PACKAGE_NAME}

echo "cleaning eventual py[co] files"
find . -name "*.py[co]" -exec rm -rf {} \;

echo "executing python setup.py build"
python setup.py	build

echo "uploading it to pypi"
python setup.py sdist upload || { echo "pypi upload failed"; exit 1; }

popd # cloned folder
popd # tmpdir

echo "removing temp dir ${TMPDIR}"
rm -rf ${TMPDIR}

echo "done!"

