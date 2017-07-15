name 'virtualbox'
maintainer 'Jesse McFarland'
maintainer_email 'jesse@mcfarland.sh'
license 'MIT'
description 'Installs/Configures virtualbox'
long_description 'Installs/Configures virtualbox'
version '0.2.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/jessemcfarland/virtualbox/issues'
source_url 'https://github.com/jessemcfarland/virtualbox'
supports 'centos'

depends 'build-essential', '~> 8.0.3'
