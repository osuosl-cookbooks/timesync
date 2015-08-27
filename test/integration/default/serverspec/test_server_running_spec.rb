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
end
