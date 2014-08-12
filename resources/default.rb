#
# Cookbook Name:: cvs_wrapper
# Resource:: default
#
# Copyright (C) 2013-2014 Tnarik Innael
# 
# All rights reserved - Do Not Redistribute
#

actions :create
default_action :create

attribute :cookbook, :kind_of => String, :default => "cvs_wrapper"
attribute :cvs_hostalias, :kind_of => String, :name_attribute => true
attribute :cvs_hostname, :kind_of => String
attribute :cvs_port, :kind_of => [Integer, String], :default => 2401
attribute :cvs_jumpbox, :kind_of => [String, NilClass], :default => nil
attribute :cvs_jumpbox_user, :kind_of => [String, NilClass], :default => nil
attribute :cvs_jumpbox_identity_file, :kind_of => [String, NilClass], :default => nil
attribute :cvs_jumpbox_identity_file_source, :kind_of => [String, NilClass], :default => nil
attribute :cvs_jumpbox_sleep, :kind_of => Integer, :default => 1
attribute :user, :kind_of => String
