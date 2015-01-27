require 'spec_helper'

describe 'cvs_wrapper::dependencies' do

  if os[:family] == 'solaris'
    describe package('CSWcvs') do
      puts os[:family]
      it { should be_installed }
    end
  else
    describe package('cvs') do
      puts os[:family]
      it { should be_installed }
    end
  end 

  describe command('which cvs') do
    its(:exit_status) { should eq 0 }
  end
  
end