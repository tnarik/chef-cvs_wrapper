#
# Cookbook Name:: cvs_wrapper
# Spec:: default
#
# Copyright (c) 2014-2015 Tnarik Innael, All Rights Reserved.

require 'spec_helper'

describe 'cvs_wrapper::dependencies' do

  context 'When all attributes are default, on an unspecified platform' do

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs cvs' do
      expect(chef_run).to install_package("cvs")
    end

  end
end
