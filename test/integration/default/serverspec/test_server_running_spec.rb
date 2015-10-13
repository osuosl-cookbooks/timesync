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

# database
describe 'install and start the Postgres database' do
  describe service('postgresql') do
    it { should be_running }
  end
  describe port(5432) do
    it { should be_listening }
  end
end

describe 'create user and group' do
  describe user('timesync') do
    it { should exist }
  end
  describe group('timesync') do
    it { should exist }
  end
end
