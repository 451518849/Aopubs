#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
echo "This is a pull request. No deployment will be done."
exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
echo "Testing on a branch other than master. No deployment will be done."
exit 0
fi
PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/patient_adolescent_spin_distribute.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"
xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa"
if [ ! -z "$FIR_APP_TOKEN" ]; then
echo ""
echo "***************************"
echo "*   Uploading to Fir.im   *"
echo "***************************"
fir p $OUTPUTDIR/$APP_NAME.ipa \
-T $FIR_APP_TOKEN
fi
