require 'serverspec'
#  The commented out code can be used to trigger the specs against a host via SSH, after commenting the Exec inclusion.
#   I was just playing with this and, althought it is not the best place, decided to keep it 'documented' here
#   Tests can be triggered by 'rspec --default_path test/integration/default/serverspec/ -I test/integration/default/serverspec'
# require 'net/ssh'
# include Serverspec::Helper::Ssh

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
# c.disable_sudo = true
# c.host  = 'machine'
# c.ssh   = Net::SSH.start(c.host, 'user', Net::SSH::Config.for(c.host))
end
