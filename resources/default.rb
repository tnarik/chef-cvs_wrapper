#
# Cookbook Name:: cvs_wrapper
# Resource:: default
#
# Copyright (c) 2013-2015 Tnarik Innael, All Rights Reserved

actions :create
default_action :create

attribute :cvs_jumpbox_identity_file, kind_of: [String, NilClass], default: nil
attribute :cvs_jumpbox_identity_file_source, kind_of: [String, NilClass], default: nil

#### from here ######
attribute :cvs_hostalias, kind_of: String, name_attribute: true
attribute :cvs_hostname, kind_of: String
attribute :cvs_port, kind_of: [Integer, String], default: 2401

attribute :cvs_jumpbox, kind_of: [String, NilClass], default: nil
attribute :cvs_jumpbox_key, kind_of: [String, NilClass], default: nil
attribute :cvs_jumpbox_identity_file, kind_of: [String, NilClass], default: nil
attribute :cvs_jumpbox_identity_file_source, kind_of: [String, NilClass], default: nil


attribute :cvs_jumpbox_user, kind_of: [String, NilClass], default: nil
attribute :cvs_jumpbox_sleep, kind_of: Integer, default: 3

attribute :cvs_bin_parent, kind_of: [String, NilClass], default: nil


attribute :cookbook, kind_of: String, default: 'cvs_wrapper'

attribute :user, kind_of: String
attribute :group, kind_of: [String, Integer, NilClass], default: nil
