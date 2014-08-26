require 'spec_helper'

context "System Ruby installation" do
  describe command('/usr/local/bin/ruby -v') do
    it { should return_exit_status 0 }
  end
end
