require 'serverspec'
set :backend, :exec

# timesync app
describe port(8000) do
  it { should be_listening }
end

describe command('curl http://localhost/v0/') do
  its(:stdout) { should contain('Cannot GET /v0/') }
  its(:exit_status) { should eq 0 }
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

describe file('/etc/pm2/conf.d/timesync.json') do
  it { should contain('"TIMESYNC_AUTH_MODULES":"[\"password\", \"ldap\"]"') }
  it { should contain('"TIMESYNC_LDAP_URL":"ldaps://ldap.osuosl.org/"') }
  it do
    should contain('"TIMESYNC_LDAP_SEARCH_BASE":"ou=People,dc=osuosl,dc=org"')
  end
end
