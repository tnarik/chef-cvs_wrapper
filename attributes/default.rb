default[:system_ruby][:version] = "2.0.0-p353"
default[:system_ruby][:destination_bin_path] = "/usr/local/bin"

default[:cvs_wrapper][:user_subdir] = ".cvs_wrapper.d"

default[:cvs_wrapper][:bindir] = "bin"
default[:cvs_wrapper][:etcdir] = "etc"
default[:cvs_wrapper][:shim] = "cvs_wrapper"
default[:cvs_wrapper][:config] = "config"

default[:cvs_wrapper][:style] = "static" # "static" | "auto"