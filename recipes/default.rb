#
# Cookbook Name:: cvs_wrapper
# Recipe:: default
#
# Copyright (c) 2013-15 Tnarik Innael, All Rights Reserved.

#include_recipe "#{cookbook_name}::environment"
#
#template "/etc/profile.d/cvs_wrapper.sh" do
#  cookbook cookbook_name.to_s
#  source "cvs_wrapper.erb.sh"
#  variables(
#    path: node[:system_ruby][:bin_path]
#  )
#  mode 0755
#end

case node["platform"]
when "solaris2"
  pkgutil_package "cvs" do 
    action :install
  end
else
 package "cvs" do
   action :install
 end
end
