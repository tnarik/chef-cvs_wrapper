#
# Cookbook Name:: cvs_wrapper
# Provider:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

def whyrun_supported?
  true
end

use_inline_resources

action :create do
	converge_by("created cvs wrapper for #{new_resource.name}") do
    
		Chef::Log.info "Create user [#{new_resource.user}]"
		user new_resource.user do
		end.run_action(:create)

		# Reload Ohai passwd
		ohai "reload_passwd" do
    	plugin "passwd"
		end
		
    cvs_wrapper_folder = ::File.expand_path(".cvs_wrapper.d", "~#{new_resource.user}")

    directory cvs_wrapper_folder do
      owner new_resource.user
      group new_resource.user
      recursive true
      action :create
    end.run_action(:create)

    template ::File.expand_path("cvs_wrapper", cvs_wrapper_folder) do
      owner new_resource.user
      group new_resource.user
      cookbook new_resource.cookbook
      source "cvs.erb"
      mode 0755
    end   

		# Set host aliases
    hostsfile_entry "local_#{new_resource.cvs_hostalias}" do
      ip_address "127.0.0.1"
      hostname  "local_#{new_resource.cvs_hostalias}"
      action :append
    end

    hostsfile_entry "direct_#{new_resource.cvs_hostalias}" do
      ip_address new_resource.cvs_hostname
      hostname  "direct_#{new_resource.cvs_hostalias}"
      action :append
    end

    # configure: 
    # - a tunnel for the host
    # - the key for that host
    # - an alias for the host
    # - remote and local entry in hosts
    # - files for the cvs_wrapper
    # cvs_wrapper "" do
    # end

#    # Require installation of the Jumpbox SSH key for the user (where does it come from?)
#    chef_gem "chef-vault"
#    require 'chef-vault'
#    
#    begin
#    	item = ChefVault::Item.load("secrets", "vaultuser")
#    	log item["vaultuser"]
#    rescue ChefVault::Exceptions::SecretDecryption
#    	log "The VF Assembler secret could not be decrypted" do
#      	level :error
#    	end
#    	# raise "The VF Assembler secret could not be decrypted"
#    end

		ssh_config "tunnel_#{new_resource.name}" do
			options User: new_resource.cvs_jumpbox_user,
          Hostname: new_resource.cvs_jumpbox,
          IdentityFile: "~/.ssh/id_rsa_mmmvf",
          LocalForward: "#{new_resource.cvs_port} #{new_resource.cvs_hostname}:#{new_resource.cvs_port}",
          Compression: "yes"
      user new_resource.user
		end

    ruby_block "check_existance_of_private_key" do
    	block do
    		raise "No existe el archivo seguro para el tunnel, please make sure you copy it!!! "
    	end
    	not_if { ::File.exists?("/home/developer/.ssh/id_rsa_mmmvf") }
      action :nothing
    end
  end
end
