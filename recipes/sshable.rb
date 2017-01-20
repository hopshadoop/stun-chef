######## CHANGE ########
kagent_keys "/home/#{node.stun.user}" do
  cb_user "#{node.stun.user}"
  cb_group "#{node.stun.group}"
  cb_name "stun"
  cb_recipe "sshable"  
  action :get_publickey
end  