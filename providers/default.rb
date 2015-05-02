#
# Cookbook Name:: cvs_wrapper
# Provider:: default
#
# Copyright (c) 2013-15 Tnarik Innael, All Rights Reserved.

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  converge_by("created cvs wrapper for #{new_resource.cvs_hostalias}") do
#    sudo new_resource.user do
#      user new_resource.user
#      runas 'root'
#      nopasswd true
#      only_if { node[:cvs_wrapper][:sudo] }
#    end
#
    require 'etc'

    cvs_wrapper_folder = ::File.expand_path(node[:cvs_wrapper][:user_dir], "~#{new_resource.user}")
    cvs_wrapper_etc_folder = ::File.expand_path(node[:cvs_wrapper][:etc_dir], cvs_wrapper_folder)
    cvs_wrapper_bin_folder = ::File.expand_path(node[:cvs_wrapper][:bin_dir], cvs_wrapper_folder)

    # Directory structure
    [cvs_wrapper_folder, cvs_wrapper_etc_folder, cvs_wrapper_bin_folder].each do |path|
      directory path do
        owner new_resource.user
        group new_resource.group || Etc.getpwnam(new_resource.user).gid
        recursive true
        action :create
      end
    end

    # CVS 'binary' wrapper
    chef_gem "ptools" do
      compile_time true
    end
    require 'ptools'
    template ::File.expand_path('cvs', new_resource.cvs_bin_parent) do
      owner new_resource.user
      group new_resource.group || Etc.getpwnam(new_resource.user).gid
      cookbook new_resource.cookbook
      source "cvs.erb"
      mode 0755
      variables(
        wrapper_path: ::File.expand_path(node[:cvs_wrapper][:shim], cvs_wrapper_bin_folder),
        cvs_path: ::File.dirname(::File.which('cvs'))
      )
    end

    # CVS shell wrapper
    template ::File.expand_path(node[:cvs_wrapper][:shim], cvs_wrapper_bin_folder) do
      owner new_resource.user
      group new_resource.group || Etc.getpwnam(new_resource.user).gid
      cookbook new_resource.cookbook
      source "cvs_shim.erb"
      mode 0755
    end

    shelly_source ::File.expand_path(node[:cvs_wrapper][:shim], cvs_wrapper_bin_folder) do
      owner 'developer'
    end

    # Set configuration
    if new_resource.cvs_jumpbox.nil?
      hostsfile_entry new_resource.cvs_hostalias do
        hostname  new_resource.cvs_hostalias
        ip_address new_resource.cvs_hostname
        unique true
        action :append
      end
      direct_connection_detected = true.to_s
    else
      # Set host aliases
      # - through the tunnel
      hostsfile_entry "local_#{new_resource.cvs_hostalias}" do
        hostname  "local_#{new_resource.cvs_hostalias}"
        ip_address "127.0.0.1"
        unique true
        action :append
      end

      # - directly
      hostsfile_entry "direct_#{new_resource.cvs_hostalias}" do
        hostname  "direct_#{new_resource.cvs_hostalias}"
        ip_address new_resource.cvs_hostname
        unique true
        action :append
      end

      # set up files for the cvs_wrapper

#    # Require installation of the Jumpbox SSH key for the user (where does it come from?)
#    chef_gem "chef-vault"
#    require 'chef-vault'
#
#    begin
#     item = ChefVault::Item.load("secrets", "vaultuser")
#     log item["vaultuser"]
#    rescue ChefVault::Exceptions::SecretDecryption
#     log "The VF Assembler secret could not be decrypted" do
#       level :error
#     end
#     # raise "The VF Assembler secret could not be decrypted"
#    end

#      jumpbox_identity_file = ::File.expand_path(new_resource.cvs_jumpbox_identity_file || "", "~#{new_resource.user}")

#      ruby_block "add_private_key" do
#        block do
#          ::FileUtils.cp new_resource.cvs_jumpbox_identity_file_source, jumpbox_identity_file
#          ::FileUtils.chown new_resource.user, new_resource.user, jumpbox_identity_file
#          # raise "No existe el archivo seguro para el tunnel, please make sure you copy it!!! "
#        end
#        not_if { ::File.exists?(jumpbox_identity_file) }
#      end


      # Set tunnel configuration
      ssh_config "tunnel_#{new_resource.cvs_hostalias}" do
        options ({
            User: new_resource.cvs_jumpbox_user,
            Hostname: new_resource.cvs_jumpbox,
            IdentityFile: '/var/id_rsa_4096', #new_resource.cvs_jumpbox_identity_file
            LocalForward: "#{new_resource.cvs_port} #{new_resource.cvs_hostname}:#{new_resource.cvs_port}",
            Compression: 'yes'
        })
        user new_resource.user
        action :add
      end

      ssh_known_hosts new_resource.cvs_jumpbox do
        hashed false
        key new_resource.cvs_jumpbox_key unless new_resource.cvs_jumpbox_key.nil?
        user new_resource.user
      end

      # Configure access for "static" mode.
      if node[:cvs_wrapper][:style] == "static"
        chef_gem "thecon" do
          compile_time true
        end
        require 'thecon'
        
        direct_connection_detected = Thecon.ready?(new_resource.cvs_port, new_resource.cvs_hostname).to_s

        hostsfile_entry new_resource.cvs_hostalias do
          hostname new_resource.cvs_hostalias
          ip_address((direct_connection_detected == true.to_s) ? new_resource.cvs_hostname : "127.0.0.1")
          unique true
          action :append
        end
      else
        direct_connection_detected = "auto"
      end
    end

    # Generate cvs_wrapper configuration file
    template ::File.expand_path("#{new_resource.cvs_hostalias}_#{new_resource.cvs_port}", cvs_wrapper_etc_folder) do
      owner new_resource.user
      group new_resource.group || Etc.getpwnam(new_resource.user).gid
      cookbook new_resource.cookbook
      source "cvs_wrapper_config.erb"
      variables(
        direct: direct_connection_detected,
        hostalias: new_resource.cvs_hostalias,
        ip: new_resource.cvs_hostname,
        port: new_resource.cvs_port,
        tunnel: "tunnel_#{new_resource.cvs_hostalias}",
        sleep: new_resource.cvs_jumpbox_sleep
      )
      mode 0755
    end
  end
end
