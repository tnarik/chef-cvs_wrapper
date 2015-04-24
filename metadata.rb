name             'cvs_wrapper'
maintainer       'Tnarik Innael'
maintainer_email 'tnarik@lecafeautomatique.co.uk'
license          'all_rights'
description      'Installs/Configures cvs_wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/tnarik/chef-cvs_wrapper'
issues_url       'https://github.com/tnarik/chef-cvs_wrapper/issues'
version          '0.2.0'

# ssh_known_hosts / ssh_user / ssh
#%w{hostsfile sudo tar ruby_install ssh-util}.each do |cookbook|
%w{hostsfile}.each do |cookbook|
  depends cookbook
end

%w{solaris2}.each do |os|
  supports os
end