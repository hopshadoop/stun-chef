name             "stun"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs stun server'
version          "0.0.1"

recipe            "stun::install",      "Install stun binaries"
recipe            "stun::default",      "Starts the (random) stun server"
recipe            "stun::sshable",      "Copies a public key to this server so you can use it to ssh"
recipe            "stun::purge",        "Stops the stun server and deletes all its files"

%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

depends "java"
depends "kagent"
depends "conda"

##### karamel/chef
attribute "java/jdk_version",
          :description => "Version of Java to use (e.g., '7' or '8')",
          :type => "string"

attribute "kagent/enabled",
          :description => "'true' by default",
          :type => "string"

##### install
attribute "install/dir",
          :description => "Default ''. Set to a base directory under which all hops services will be installed.",
          :type => "string"

attribute "install/user",
          :description => "User to install the services as",
          :type => "string"

attribute "stun/group",
          :description => "group parameter value",
          :type => "string"

attribute "stun/user",
          :description => "user parameter value",
          :type => "string"

attribute "stun/dir",
          :description => "Base directory for stun installation (default: '/srv')",
	  :type => "string"

##### app
attribute "stun/log_level",
          :description => "Default: WARN. Can be INFO or DEBUG or TRACE or ERROR.",
          :type => "string"

attribute "stun/type",
          :description => "type (odd/even) for the stun instance(related to id - if id provided manually, it should match).",
          :type => "string"

attribute "stun/id",
          :description => "id for the stun instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "stun/seed",
          :description => "seed for the dela instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "stun/stun_port1",
          :description => "1st stun server port used.",
          :type => "string"

attribute "stun/stun_port2",
          :description => "2nd stun server port used.", 
          :type => "string"

attribute "stun/port",
	    :description => "internal stun server port.",
	    :type => "string"

attribute "stun/bootstrap/ip",
         :description => "stun bootstrap ip.",
         :type => "string"

attribute "stun/bootstrap/port",
         :description => "stun bootstrap port.",
         :type => "string"

attribute "stun/bootstrap/id",
         :description => "stun bootstrap id.",
         :type => "string"