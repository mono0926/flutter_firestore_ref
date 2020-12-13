#!/usr/bin/env zsh

flutter drive \
  --driver=integration_test/driver.dart \
  --target=integration_test/app_test.dart \
  -d $1