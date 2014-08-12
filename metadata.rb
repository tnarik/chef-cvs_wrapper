name             'cvs_wrapper'
maintainer       'Tnarik Innael'
maintainer_email 'tnarik@lecafeautomatique.co.uk'
license          'All rights reserved'
description      'Installs/Configures cvs_wrapper'
long_description 'Installs/Configures cvs_wrapper'
version          '0.1.0'

#ssh_known_hosts / ssh_user / ssh
%w{sudo tar ruby_install ssh-util}.each do |cookbook|
  depends cookbook
end

depends 'hostsfile', '>= 2.0.1'