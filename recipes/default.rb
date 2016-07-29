#
# Cookbook Name:: timesync
# Recipe:: default
#
# Copyright 2015 Oregon State University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

pg = Chef::EncryptedDataBagItem.load(
  node['timesync']['databag'],
  node['timesync']['pg_info']
)

secret_key = Chef::EncryptedDataBagItem.load(node['timesync']['databag'], 'key')

environment = {
  'PG_CONNECTION_STRING' => "postgres://#{pg['user']}:#{pg['pass']}@" \
    "#{pg['host']}:#{pg['port']}/#{pg['database_name']}",
  'NODE_ENV' => 'production_pg',
  'SECRET_KEY' => secret_key['key'],
  'INSTANCE_NAME' => node['timesync']['instance_name'],
  'TIMESYNC_AUTH_MODULES' => '["password", "ldap"]',
  'TIMESYNC_LDAP_URL' => node['timesync']['ldap_url'],
  'TIMESYNC_LDAP_SEARCH_BASE' => node['timesync']['ldap_search']
}

nodejs_webapp 'timesync' do
  path node['timesync']['application_path']
  user node['timesync']['user']
  group node['timesync']['group']
  env environment

  script 'src/app.js'
  repository node['timesync']['repo']
  branch node['timesync']['branch']
  node_args node['timesync']['node_args']
end

bash 'run timesync migrations' do
  code 'npm run migrations'
  env environment
  cwd "#{node['timesync']['application_path']}/source"
end

execute 'create root user' do
  command "npm run create-account -- -u root -p #{secret_key['root_pass']}"
  environment environment
  sensitive true
  cwd "#{node['timesync']['application_path']}/source"
end

pm2_application 'timesync' do
  user node['timesync']['user']
  action :start_or_graceful_reload
end
