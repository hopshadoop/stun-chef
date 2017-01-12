case node.platform
when "ubuntu"
 if node.platform_version.to_f <= 14.04
   node.override.stun.systemd = "false"
 end
end

if node.stun.id.nil?
    node.override.stun.id = Time.now.getutc.to_i
end

if node.stun.seed.nil?
    node.override.stun.seed = Random.rand(100000)
end

template "#{node.stun.home}/conf/application.conf" do
  source "application.conf.erb" 
  owner node.stun.user
  group node.stun.group
  mode 0750
  variables({ 
     :stun1_ip => stun1_ip,
     :stun2_ip => stun2_ip,
     :stun1_id => stun1_id,
     :stun2_id => stun2_id
  })
end

service_name="stun"

if node.stun.systemd == "true"

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


if node.kagent.enabled == "true" 
   kagent_config service_name do
     service service_name
     log_file "#{node.stun.home}/stun.log"
     config_file "#{node.stun.home}/conf/application.conf"
   end
end
