bash 'kill_running_interpreters' do
    user "root"
    ignore_failure true
    code <<-EOF
      service stun stop
    EOF
end


directory node.stun.home do
  recursive true
  action :delete
  ignore_failure true
end

link node.stun.base_dir do
  action :delete
  ignore_failure true
end


