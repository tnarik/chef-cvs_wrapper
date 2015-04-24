# System Ruby
default[:system_ruby][:version] = "ruby 2.1.2"
default[:system_ruby][:bin_path] = "/usr/local/bin"

default[:cvs_wrapper][:config] = "config"

# 'static' (connection mode identified and set during installation) | 'auto' (connection mode detected during runtime, requires 'sudo')
default[:cvs_wrapper][:style] = 'static'

default[:cvs_wrapper][:sudo] = true # true | false

default[:cvs_wrapper][:shim] = 'cvs_wrapper'

# CVS wrapper folder structure
default[:cvs_wrapper][:user_dir] = '.cvs_wrapper.d'
default[:cvs_wrapper][:bin_dir] = 'bin'
default[:cvs_wrapper][:etc_dir] = 'etc'