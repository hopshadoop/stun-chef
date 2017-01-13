include_recipe "stun::default"

homedir = "/home/#{node.stun.user}"

kagent_keys "#{homedir}" do
  cb_user "#{node.stun.user}"
  cb_group "#{node.stun.group}"
  cb_name "stun"
  cb_recipe "server"  
  action :get_publickey
end  
