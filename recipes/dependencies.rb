#
# Cookbook Name:: cvs_wrapper
# Recipe:: dependencies
#
# Copyright (c) 2014-2015 Tnarik Innael, All Rights Reserved.

# CVS
case node[:platform]
when 'solaris2'
  pkgutil_package "cvs" do 
    action :install
  end
else
  package 'cvs' do
    action :install
  end
end

# FOR THE WRAPPER
#gem_package 'thecon' do
#  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
#end
#
#gem_package 'hostsfile' do
#  gem_binary File.join(node[:system_ruby][:bin_path], "gem")
#end