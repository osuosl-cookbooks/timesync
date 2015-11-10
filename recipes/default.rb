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

pg = Chef::EncryptedDataBagItem.load(node['timesync']['databag'],
                                     'pg')

environment = {
  PG_CONNECTION_STRING: "postgres://#{pg['user']}:#{pg['pass']}@#{pg['host']}" \
    ":#{pg['port']}/#{pg['database_name']}",
  NODE_ENV: 'production'
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
  code 'echo hi' # npm run migrations
  # environment(
  #   PG_CONNECTION_STRING: "postgres://#{pg['user']}:#{pg['pass']}@#{pg['host']}" \
  #     ":#{pg['port']}/#{pg['database_name']}",
  #   NODE_ENV: 'production'
  # )
  env(foo: "bar")
  cwd "#{node['timesync']['application_path']}/source"
end

pm2_application 'timesync' do
  user node['timesync']['user']
  action :restart
end
