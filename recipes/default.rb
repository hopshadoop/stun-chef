include_recipe "stun::base-default"

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

if node.kagent.enabled == "true" 
   kagent_config service_name do
     service service_name
     log_file "#{node.stun.home}/stun.log"
     config_file "#{node.stun.home}/conf/application.conf"
   end
end
