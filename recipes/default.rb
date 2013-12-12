#
# Cookbook Name:: cvs_wrapper
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "ruby_build" # How to make sure this recipe is idempotent and doesn't connect when not needed?

ruby_version = node[:system_ruby][:version]
ruby_version_path = "#{node['ruby_build']['default_ruby_base_path']}/#{ruby_version}"
ruby_system_path = "#{node['ruby_build']['default_ruby_base_path']}/system"

# How to make sure ruby_build_ruby is idempotent ?
ruby_build_ruby ruby_version do
	prefix_path ruby_version_path
end

link ruby_system_path do
	to ruby_version_path
end

ruby_block "link_ruby_from_destination_bin_path" do
	block do
		Dir.glob("#{ruby_system_path}/bin/*") do |ruby_system_path_bin|

			# Using /bin works as I wanted
			link_destination = ::File.join(node[:system_ruby][:destination_bin_path], ::File.basename(ruby_system_path_bin))
			link = Chef::Resource::Link.new(link_destination, run_context)
			link.to ruby_system_path_bin
			link.run_action :create
		end
	end
end

gem_package 'thecon' do
  gem_binary File.join(node[:system_ruby][:destination_bin_path], "gem")
end

gem_package 'hostsfile' do
	gem_binary File.join(node[:system_ruby][:destination_bin_path], "gem")
	source "/vagrant/hostsfile-0.0.1.gem"
end