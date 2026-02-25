#!/bin/bash

set -euo pipefail

#realpath() {
#    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
#}
#CURRENTDIR=$(dirname $(realpath "$0"))
SCRIPTDIR="$(cd "$(dirname "$0")" && pwd -P)"

cat ${SCRIPTDIR}/../../src/Lib.Core/Constants.cs | grep "VersionDesc = \"" | awk -F"\"" '{print $2}'

exit 0

