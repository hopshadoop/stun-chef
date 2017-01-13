
include_recipe "java"

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

