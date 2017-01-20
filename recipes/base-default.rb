########### CHANGE ###########
service_name=node.stun.service

case node.platform
when "ubuntu"
 if node.platform_version.to_f <= 14.04
   node.override.stun.systemd=node_systemd = "false"
 end
end

node_systemd=node.stun.systemd
###### NO NEED TO CHANGE #####

if node_systemd == "true"
  service service_name do
    provider Chef::Provider::Service::Systemd
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  case node.platform_family
  when "rhel"
    systemd_script = "/usr/lib/systemd/system/#{service_name}.service" 
  else
    systemd_script = "/lib/systemd/system/#{service_name}.service"
  end

  template systemd_script do
    source "#{service_name}.service.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :start, resources(:service => service_name), :immediately
  end

  # This is needed so that the service can be started by systemd
  kagent_config "reload_#{service_name}" do
    action :systemd_reload
  end  

else #sysv
  service service_name do
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  template "/etc/init.d/#{service_name}" do
    source "#{service_name}.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :restart, resources(:service => service_name), :immediately
  end
end