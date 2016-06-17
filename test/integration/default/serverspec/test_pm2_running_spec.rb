require 'serverspec'
set :backend, :exec

# pm2
describe file('/etc/pm2/conf.d/timesync.json') do
  it { should be_file }
end

describe process('node') do
  it { should be_running }
  its(:args) { should match '/opt/timesync/source/src/app.js' }
end

describe command('su -c "pm2 ls" timesync') do
  its(:stdout) { should match /timesync.*online/ }
  its(:stderr) { should eq "" }
end

