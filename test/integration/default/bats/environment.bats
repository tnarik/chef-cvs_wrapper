#!/usr/bin/env bats

@test "System Ruby installation is available" {
  run /usr/local/bin/ruby -v
  [ "$status" -eq 0 ]
}
