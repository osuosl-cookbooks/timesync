default['timesync']['server_name'] = node['fqdn']
default['timesync']['port'] = 8000

default['haproxy']['members'] = [
  {
    'hostname' => 'localhost',
    'ipaddress' => '127.0.0.1',
    'port' => 8000
  }
]
