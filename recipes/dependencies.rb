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

gem_package 'hostsfile' do
  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
end
