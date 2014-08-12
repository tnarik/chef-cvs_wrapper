#!/usr/bin/env bats

@test "System Ruby installation is available" {
/usr/local/bin/ruby -v  
#ruby -v
  run /usr/local/bin/ruby -v
  #run which ruby
  [ "$status" -eq 0 ]
}
