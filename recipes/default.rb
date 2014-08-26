#
# Cookbook Name:: cvs_wrapper
# Recipe:: default
#
# Copyright (C) 2013-2014 Tnarik Innael
#
# All rights reserved - Do Not Redistribute
#

include_recipe "#{cookbook_name}::environment"

template "/etc/profile.d/cvs_wrapper.sh" do
  cookbook cookbook_name.to_s
  source "cvs_wrapper.erb.sh"
  variables(
    path: node[:system_ruby][:bin_path]
  )
  mode 0755
end
