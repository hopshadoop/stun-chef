include_recipe "stun::base-default"

# service_name defined in base-default
service_name=node.stun.service
if node.kagent.enabled == "true" 
   kagent_config service_name do
     service service_name
     log_file "#{node.stun.logs}"
     config_file "#{node.stun.home}/conf/application.conf"
   end
end
