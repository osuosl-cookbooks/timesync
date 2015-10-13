#
# Cookbook Name:: timesync
# Recipe:: database
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

include_recipe 'postgresql::client'

pg = Chef::EncryptedDataBagItem.load(node['timesync']['databag'],
                                     'pg')

magic_shell_environment 'PG_CONNECTION_STRING' do
  value "postgres://#{pg['user']}:#{pg['pass']}@#{pg['host']}:#{pg['port']}/" \
    "#{pg['database_name']}"
end

magic_shell_environment 'NODE_ENV' do
  value 'production'
end
