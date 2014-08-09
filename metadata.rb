name             'cvs_wrapper'
maintainer       'Tnarik Innael'
maintainer_email 'tnarik@lecafeautomatique.co.uk'
license          'All rights reserved'
description      'Installs/Configures cvs_wrapper'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

#ssh_known_hosts
%w{sudo ruby_build ssh_user ssh}.each do |cookbook|
  depends cookbook
end

depends 'hostsfile', '>= 2.0.1'