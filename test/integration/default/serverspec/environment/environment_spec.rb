require 'spec_helper'

describe "System Ruby installation" do
  describe command('/usr/local/bin/ruby -v') do
    it { should return_exit_status 0 }
  end
end
