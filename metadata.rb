name             'timesync'
maintainer       'Oregon State University'
maintainer_email 'chef@osuosl.org'
license          'apache2'
description      'Installs/Configures timesync'
long_description 'Installs/Configures timesync'
version          '0.3.1'

depends 'build-essential'
depends 'database'
depends 'git'
depends 'haproxy'
depends 'magic_shell'
depends 'nodejs'
depends 'nodejs-webapp'
depends 'pm2'
depends 'postgresql'

supports 'centos', '~> 7.0'
