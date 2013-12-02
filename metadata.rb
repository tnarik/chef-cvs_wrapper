name             'cvs_wrapper'
maintainer       'Tnarik Innael'
maintainer_email 'tnarik@lecafeautomatique.co.uk'
license          'All rights reserved'
description      'Installs/Configures cvs_wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{hostsfile ssh_config ssh_known_hosts}.each do |cookbook|
  depends cookbook
end