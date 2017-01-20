
include_recipe "java"

# hack until groups attrs work in karamel
node.override.stun.bootstrap.ip = "192.168.56.101"
node.override.stun.bootstrap.port = 30000
node.override.stun.bootstrap.id = 1

if my_private_ip().eql?("192.168.56.102")
  node.override.stun.type = "even"
  node.override.stun.id =  2
end
if my_private_ip().eql?("192.168.56.103")
  node.override.stun.type = "odd"
  node.override.stun.id =  3
end
####

group node.stun.group do
  action :create
  not_if "getent group #{node.stun.group}"
end

user node.stun.user do
  home "/home/#{node.stun.user}"
  system true
  shell "/bin/bash"
  manage_home true
  action :create
  not_if "getent passwd #{node.stun.user}"
end

group node.stun.group do
  action :modify
  members ["#{node.stun.user}"]
  append true
end

directory "#{node.stun.home}" do
  owner node.stun.user
  group node.stun.group
  mode "775"
  action :create
  recursive true
  not_if { File.directory?("#{node.stun.home}") }
end


directory "#{node.stun.home}/bin" do
  owner node.stun.user
  group node.stun.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.stun.home}/bin") }
end

directory "#{node.stun.home}/conf" do
  owner node.stun.user
  group node.stun.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.stun.home}/conf") }
end

directory "#{node.stun.home}/lib" do
  owner node.stun.user
  group node.stun.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.stun.home}/lib") }
end

for script in node.stun.scripts do
  template "#{node.stun.home}/bin/#{script}" do
    source "#{script}.erb"
    owner node.stun.user
    group node.stun.group
    mode 0750
  end
end

url = node.stun.url

remote_file "#{node.stun.home}/lib/stun.jar" do
  source url
  retries 2
  owner node.stun.user
  group node.stun.group
  mode "0755"
  # TODO - checksum
  action :create_if_missing
end

link node.stun.base_dir do
  owner node.stun.user
  group node.stun.group
  to node.stun.home
end

if node.stun.id.nil?
    node.override.stun.id = Time.now.getutc.to_i
end

if node.stun.seed.nil?
    node.override.stun.seed = Random.rand(100000)
end

if !node.stun.id.is_a?(Integer)
    node.override.stun.id = node.stun.id.to_i
end
if node.stun.type.eql?("odd")
  if node.stun.id.even?
    node.override.stun.id = node.stun.id+1
  end
end
if node.stun.type.eql?("even")
  if node.stun.id.odd?
    node.override.stun.id = node.stun.id+1
  end
end

template "#{node.stun.home}/conf/application.conf" do
  source "application.conf.erb" 
  owner node.stun.user
  group node.stun.group
  mode 0750
  variables({
  })
end

template "#{node.stun.home}/conf/log4j.properties" do
  source "log4j.properties.erb" 
  owner node.stun.user
  group node.stun.group
  mode 0750
  variables({
  })
end

