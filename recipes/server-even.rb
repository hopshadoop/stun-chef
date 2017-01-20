include_recipe "stun::default"

if node.stun.id.odd?
    node.override.stun.id = node.stun.id+1
end