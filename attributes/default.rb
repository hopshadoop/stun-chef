default.stun.group                 = "stun"
default.stun.user                  = "stun"

default.stun.public_ips            = ['10.0.2.15']
default.stun.private_ips           = ['10.0.2.15']
default.stun.systemd               = "true"

default.stun.version               = "0.0.1-SNAPSHOT"
default.stun.url                   = "http://snurran.sics.se/hops/dela/stun-server-#{node.stun.version}.jar"
default.stun.dir                   = "/srv"
default.stun.base_dir              = node.stun.dir + "/stun"
default.stun.home                  = node.stun.base_dir + "-" + node.stun.version
default.stun.logs                  = node.stun.base_dir + "/stun.log"
default.stun.scripts               = %w{ start.sh generic_start.sh stop.sh generic_stop.sh update_binaries.sh}
default.stun.pid_file              = "/tmp/stun.pid"

default.stun.log_level             = "WARN"
default.stun.id                    = nil
default.stun.seed                  = nil
default.stun.port                  = 42001
default.stun.stun_port1            = 42002
default.stun.stun_port2            = 42003
default.stun.bootstrap.ip		   = '193.0.0.1'
default.stun.bootstrap.port 	   = 30000
default.stun.bootstrap.id		   = 1