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
	converge_by("created cvs wrapper for #{new_resource.cvs_hostalias}") do
		Chef::Log.info "Create user [#{new_resource.user}]"
		user new_resource.user do
		end.run_action(:create)

		# Reload Ohai passwd
		ohai "reload_passwd" do
    	plugin "passwd"
		end
		
    cvs_wrapper_folder = ::File.expand_path(node[:cvs_wrapper][:user_subdir], "~#{new_resource.user}")
    cvs_wrapper_etc_folder = ::File.expand_path(node[:cvs_wrapper][:etcdir], cvs_wrapper_folder)
    cvs_wrapper_bin_folder = ::File.expand_path(node[:cvs_wrapper][:bindir], cvs_wrapper_folder)

    directory cvs_wrapper_folder do
      owner new_resource.user
      group new_resource.user
      recursive true
      action :create
    end.run_action(:create)

    directory cvs_wrapper_etc_folder do
      owner new_resource.user
      group new_resource.user
      recursive true
      action :create
    end.run_action(:create)

    directory cvs_wrapper_bin_folder do
      owner new_resource.user
      group new_resource.user
      recursive true
      action :create
    end.run_action(:create)

    template ::File.expand_path(node[:cvs_wrapper][:shim], cvs_wrapper_bin_folder) do
      owner new_resource.user
      group new_resource.user
      cookbook new_resource.cookbook
      source "cvs_shim.erb"
      mode 0755
    end   

    template ::File.expand_path(node[:cvs_wrapper][:config], cvs_wrapper_folder) do
      owner new_resource.user
      group new_resource.user
      cookbook new_resource.cookbook
      source "config.erb"
      mode 0755
    end   

    if new_resource.cvs_jumpbox.nil? 
      hostsfile_entry "#{new_resource.cvs_hostalias}" do
        ip_address new_resource.cvs_hostname
        hostname  "#{new_resource.cvs_hostalias}"
        unique true
        action :append
      end

      direct_connection_detected = true.to_s
    else
		  # Set host aliases
      # through the tunnel
      hostsfile_entry "local_#{new_resource.cvs_hostalias}" do
        ip_address "127.0.0.1"
        hostname  "local_#{new_resource.cvs_hostalias}"
        unique true
        action :append
      end
  
      # directly
      hostsfile_entry "direct_#{new_resource.cvs_hostalias}" do
        ip_address new_resource.cvs_hostname
        hostname  "direct_#{new_resource.cvs_hostalias}"
        unique true
        action :append
      end

    # configure: 
    # - the key for that host
    # - files for the cvs_wrapper

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

    # Add the key if a key is configured (and then create the ssh config)
#    ruby_block "check_existance_of_private_key_adding_it_please_based_on_config" do
#      block do
#         ::FileUtils.cp "/vagrant/id_rsa_mmmvf", "/home/developer/.ssh/id_rsa_mmmvf"
#         ::FileUtils.chown new_resource.user, new_resource.user, '/home/developer/.ssh/id_rsa_mmmvf'
#        #raise "No existe el archivo seguro para el tunnel, please make sure you copy it!!! "
#      end
#      not_if { ::File.exists?("/home/developer/.ssh/id_rsa_mmmvf") }
#    end


      #Redo this bit for the ssh_user cookbook
		  ssh_config "tunnel_#{new_resource.cvs_hostalias}" do
		   	options User: new_resource.cvs_jumpbox_user,
            Hostname: new_resource.cvs_jumpbox,
            IdentityFile: "~/.ssh/id_rsa_mmmvf",
            LocalForward: "#{new_resource.cvs_port} #{new_resource.cvs_hostname}:#{new_resource.cvs_port}",
            Compression: "yes"
        user new_resource.user
		   end
   
      ssh_user_known_hosts new_resource.cvs_jumpbox do
        hashed true
        user new_resource.user
      end

      #Configure initial access
      chef_gem "thecon"
      require 'thecon'
      
      if node[:cvs_wrapper][:style] == "static"
        direct_connection_detected = Thecon.ready?(new_resource.cvs_port, new_resource.cvs_hostname).to_s
      else
        direct_connection_detected = "auto"
      end

      hostsfile_entry "#{new_resource.cvs_hostalias}" do
        ip_address ( direct_connection_detected == true.to_s ) ? new_resource.cvs_hostname : "127.0.0.1"
        hostname  "#{new_resource.cvs_hostalias}"
        unique true
        action :append
      end
    end

    template ::File.expand_path("#{new_resource.cvs_hostalias}_#{new_resource.cvs_port}", cvs_wrapper_etc_folder) do
      owner new_resource.user
      group new_resource.user
      cookbook new_resource.cookbook
      source "cvs_wrapper_config.erb"
      variables ({
        direct: direct_connection_detected,
        hostalias: new_resource.cvs_hostalias,
        ip: new_resource.cvs_hostname,
        port: new_resource.cvs_port,
        tunnel: "tunnel_#{new_resource.cvs_hostalias}",
        sleep: new_resource.cvs_jumpbox_sleep
      })
      mode 0755
    end
  end
end
