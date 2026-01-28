#!/usr/bin/env bats
# shellcheck disable=SC2016
# Unit tests for bootstrap.sh

setup() {
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'
  export BATS_PROJECT_ROOT="${BATS_TEST_DIRNAME}/.."
  export MOCK_OS_RELEASE="${BATS_TMPDIR:-/tmp}/os-release.$$"
}

teardown() {
  rm -f "$MOCK_OS_RELEASE"
}

@test "bootstrap.sh has set -eou pipefail for error handling" {
  run head -n 5 "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_output --partial "set -eou pipefail"
}

@test "determine_variant function exists in bootstrap.sh" {
  run grep "^determine_variant()" "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install function exists in bootstrap.sh" {
  run grep "^install()" "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install_ubuntu variable is defined correctly" {
  run grep 'install_ubuntu="apt-get install -y"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install_darwin variable is defined correctly" {
  run grep 'install_darwin="brew install"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install_suse variable is defined correctly" {
  run grep 'install_suse="zypper in -y"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install_mariner variable is defined correctly" {
  run grep 'install_mariner="dnf install -y"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install_manjaro variable is defined correctly" {
  run grep 'install_manjaro="pacman -Sy"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "bootstrap script checks for make command existence" {
  run grep 'command -v make' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "bootstrap script checks for stow command existence" {
  run grep 'command -v stow' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "bootstrap script guards main execution with source check" {
  run grep 'BASH_SOURCE\[0\].*${0}' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "install function uses VARIANT variable for distro-specific install commands" {
  run grep -A 5 '^install()' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_output --partial '$VARIANT'
}

@test "bootstrap script doesn't have hardcoded absolute paths" {
  run bash -c "! grep -E '/(usr|opt)/[a-z]' '$BATS_PROJECT_ROOT/bootstrap.sh' || grep -q 'XDG_' '$BATS_PROJECT_ROOT/bootstrap.sh'"
  assert_success
}

@test "bootstrap script is a valid bash script" {
  run bash -n "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}

@test "bootstrap script installs make if not found" {
  run grep -A 3 'command -v make' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_output --partial 'install make'
}

@test "bootstrap script installs stow if not found" {
  run grep -A 10 'command -v stow' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_output --partial 'install stow'
}

@test "bootstrap script calls make with variant as argument" {
  run grep 'make "\$VARIANT"' "$BATS_PROJECT_ROOT/bootstrap.sh"
  assert_success
}
