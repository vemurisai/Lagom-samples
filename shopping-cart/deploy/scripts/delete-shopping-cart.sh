#!/bin/bash

##  Usage:
##    ./delete-shopping-cart.sh
##    ./delete-shopping-cart.sh <shopping-cart-java|shopping-cart-scala>
##    ./delete-shopping-cart.sh <shopping-cart-java|shopping-cart-scala> <sbt|maven>
##
CODE_VARIANT=${1:-shopping-cart-scala}
shift
BUILD_TOOL=${1:-sbt}


# Recognize the environment
SCRIPTS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMMON_SCRIPTS_DIR=$SCRIPTS_DIR/common


. $COMMON_SCRIPTS_DIR/installers.sh
installOC

# 1. Setup session and load some helping functions
. $COMMON_SCRIPTS_DIR/setupEnv.sh
setupEnv "$CODE_VARIANT" "$BUILD_TOOL"
echo "Deleting $NAMESPACE"
. $COMMON_SCRIPTS_DIR/clusterLogin.sh
clusterLogin "$CODE_VARIANT" "$BUILD_TOOL"

# 2. Load extra tools to manage the deployment
. $COMMON_SCRIPTS_DIR/deployment-tools.sh

# 3. Deleting NAMESPACE
deleteNamespace $NAMESPACE
