default['timesync']['access_log'] = "#{node['nginx']['log_dir']}/timesync/access.log"
default['timesync']['error_log'] = "#{node['nginx']['log_dir']}/timesync/error.log"

default['timesync']['server_name'] = node['fqdn']
default['timesync']['port'] = 8000

override['nginx']['default_site_enabled'] = false
