require 'serverspec'
set :backend, :exec

root_pass = "dLj+87o0fyYqPsbvlNuigpA/XFI9ThJAFjMMibEypDoJpAN0hMqBVs03fptaubFLCHBAh2mZ6lw0nlGwXhHMSQ"

describe command("curl -d '{ \
                             \"auth\": { \
                               \"type\": \"password\", \
                               \"username\": \"root\", \
                               \"password\": \"#{root_pass}\" \
                             } \
                           }' \
                       -H \"Content-Type: application/json\" http://localhost/v0/login") do
  its(:stdout) { should match(/^{\"token\":\s?\"[a-zA-Z0-9+\/=.]+\"}$/) } 
  its(:exit_status) { should eq 0 }
end
