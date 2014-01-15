name             'radiance'
maintainer       'Nicholas Long'
maintainer_email 'nicholas.long@nrelgov'
license          'All rights reserved'
description      'Installs/Configures radiance'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "ark"
depends "build-essential"
depends "cmake"
depends "apt"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end
