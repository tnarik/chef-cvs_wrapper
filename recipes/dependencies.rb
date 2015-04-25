#
# Cookbook Name:: cvs_wrapper
# Recipe:: dependencies
#
# Copyright (c) 2013-15 Tnarik Innael, All Rights Reserved.

gem_package 'thecon' do
  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
end

gem_package 'hostsfile' do
  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
end
