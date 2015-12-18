default['timesync']['server_name'] = node['fqdn']
default['timesync']['port'] = 8000

default['timesync']['application_path'] = '/opt/timesync'
default['timesync']['repo'] = 'https://github.com/osuosl/timesync-node.git'
default['timesync']['branch'] = 'develop'
default['timesync']['node_args'] = ['--harmony']
default['timesync']['user'] = 'timesync'
default['timesync']['group'] = 'timesync'
default['timesync']['databag'] = 'timesync'
default['timesync']['instance_name'] = 'timesync'

override['haproxy']['members'] = [
  {
    'hostname' => 'localhost',
    'ipaddress' => '127.0.0.1',
    'port' => 8000
  }
]

default['nodejs']['install_method'] = 'binary'
default['nodejs']['version'] = '0.12.7'
default['nodejs']['binary']['checksum']['linux_x64'] = '6a2b3077f293d17e2a1e6' \
  'dba0297f761c9e981c255a2c82f329d4173acf9b9d5'
