#
# Cookbook Name:: cvs_wrapper
# Recipe:: ruby
#
# Copyright (C) 2013-2014 Tnarik Innael
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "tar"
package "bzip2"
include_recipe "ruby_install"
#include_recipe "ruby_build"

ruby_version = node[:system_ruby][:version]
ruby_version_path = "#{node[:ruby_install][:default_ruby_base_path]}/#{ruby_version.gsub(/\s+/, '-')}"
ruby_system_path = "#{node[:ruby_install][:default_ruby_base_path]}/system"

ruby_install_ruby ruby_version

#ruby_build_ruby ruby_version do
#end


link ruby_system_path do
  to ruby_version_path
end

# Installing binaries to the system
ruby_block "link_ruby_binaries_to_system" do
  block do
    Dir.glob("#{ruby_system_path}/bin/*") do |ruby_system_path_bin|
      link_destination = ::File.join(node[:system_ruby][:bin_path], ::File.basename(ruby_system_path_bin))
      link = Chef::Resource::Link.new(link_destination, run_context)
      link.to ruby_system_path_bin
      link.run_action :create
    end
  end
end
 