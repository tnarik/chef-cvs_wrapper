require 'serverspec'

set :backend, :exec

describe package('cvs') do
  it { should be_installed }
end

describe command('which cvs') do
  its(:exit_status) { should eq 0 }
end