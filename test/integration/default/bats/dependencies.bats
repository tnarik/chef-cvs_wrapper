#!/usr/bin/env bats

@test "hostsfile gem is available" {
  unset GEM_HOME
  run /usr/local/bin/gem contents hostsfile
  [ "$status" -eq 0 ]
}

@test "thecon gem is available" {
  unset GEM_HOME
  run /usr/local/bin/gem contents thecon
  [ "$status" -eq 0 ]
}
