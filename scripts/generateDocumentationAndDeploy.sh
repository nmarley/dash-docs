#! /bin/sh
#
# - Doxygen must be installed or loaded from cache. The build-install-doxygen
#   script should be used to do this
# - A Doxygen configuration file must be located in the TRAVIS_BUILD_DIR/doxygen
#   directory
# - This script should be called after the rest of the site has already been
#   built (i.e. in the Travis-CI after_success section)
#
# Required global variables:
# - DOXYFILE            : The Doxygen configuration file.

set -e
echo 'Setting up the script...'

git clone -b develop https://github.com/dashpay/dash.git
cd dash

# Copy Doxygen config / build files
cp $TRAVIS_BUILD_DIR/doxygen/* doc/

echo 'Generating Doxygen code documentation...'
$TRAVIS_BUILD_DIR/doxygen-install/doxygen doc/$DOXYFILE 2>&1 | tee doxygen.log

echo 'Done generating Doxygen code documentation...'

# Copy Doxygen files to dash-docs folder
echo 'Copy Doxygen files to _site...'
cp -R doc/doxygen $TRAVIS_BUILD_DIR/_site/en/
