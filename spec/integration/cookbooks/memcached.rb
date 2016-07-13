package "memcached"

service "memcached" do
  action [:enable, :start]
end
