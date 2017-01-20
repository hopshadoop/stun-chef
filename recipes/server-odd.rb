include_recipe "stun::default"

if node.stun.id.even?
    node.override.stun.id = node.stun.id+1
end