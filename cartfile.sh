#!/usr/bin/env bash

# https://github.com/Carthage/Carthage/issues/3019
#Workaround that works with both Xcode 11 and 12
#Works with all versions of Xcode 12 (except beta 1 and 2; but no-one should be using those anymore). Once XCFrameworks support lands in Carthage this workaround won’t be needed. However not that XCFrameworks puts some strict requirements on projects that most projects don’t comply with.

#Note: This is a change from before where the script excluded arm64 for simulators by individual Xcode 12 version. It now removes it from all Xcode 12 based builds.

#How to use
#Save the script (👇) to your project (e.g. as a carthage.sh file).
#Make the script executable chmod +x carthage.sh
#Instead of calling carthage ... call ./carthage.sh ...
#E.g. ./carthage.sh build or ./carthage.sh update --use-submodules


# carthage.sh
# Usage example: ./carthage.sh build --platform iOS

set -euo pipefail

xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

# For Xcode 12 make sure EXCLUDED_ARCHS is set to arm architectures otherwise
# the build will fail on lipo due to duplicate architectures.
echo 'EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200 = arm64 arm64e armv7 armv7s armv6 armv8' >> $xcconfig
echo 'EXCLUDED_ARCHS = $(inherited) $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT)__XCODE_$(XCODE_VERSION_MAJOR))' >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"
carthage "$@"