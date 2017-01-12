include_recipe "stun::_default"

homedir = "/home/#{node.stun.user}"

kagent_keys "#{homedir}" do
  cb_user "#{node.stun.user}"
  cb_group "#{node.stun.group}"
  cb_name "stun"
  cb_recipe "stun-server"  
  action :get_publickey
end  
