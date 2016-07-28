#!/usr/bin/env bash

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  export CERTIFICATE_P12=Certificate.p12;
  echo $DEV_CERT_OSX_P12 | base64 --decode > $CERTIFICATE_P12;
  export KEYCHAIN=build.keychain;
  security create-keychain -p mysecretpassword $KEYCHAIN;
  security default-keychain -s $KEYCHAIN;
  security unlock-keychain -p mysecretpassword $KEYCHAIN;
  security import $CERTIFICATE_P12 -k $KEYCHAIN -P $DEV_CERT_0SX_PW -T /usr/bin/codesign;
  security find-identity -v;
  rm $CERTIFICATE_P12;
fi
