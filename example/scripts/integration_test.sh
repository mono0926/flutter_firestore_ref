#!/usr/bin/env zsh

flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/firestore_ref_test.dart \
  -d $1

flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/example_test.dart \
  -d $1