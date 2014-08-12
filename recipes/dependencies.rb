#
# Cookbook Name:: cvs_wrapper
# Recipe:: dependencies
#
# Copyright (C) 2014 Tnarik Innael
# 
# All rights reserved - Do Not Redistribute
#

gem_package 'thecon' do
  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
end

cookbook_file "hostsfile_gem_file" do
  path "/tmp/hostsfile-0.0.1.gem"
  action :create_if_missing
end

gem_package 'hostsfile' do
  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
  source "/tmp/hostsfile-0.0.1.gem"
end