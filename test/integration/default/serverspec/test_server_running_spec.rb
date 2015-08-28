require 'serverspec'
set :backend, :exec

# timesync app
describe port(8000) do
  it { should be_listening }
end

# haproxy
describe port(80) do
  it { should be_listening }
end

# database exists
describe file('/opt/timesync/source/dev.sqlite3') do
  it { should exist }
  it { should be_grouped_into 'timesync' }
  it { should be_owned_by 'timesync' }
end
