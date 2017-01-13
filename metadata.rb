name             "stun"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs stun server'
version          "0.1.0"

recipe            "stun::install", "Install stun binaries"
recipe            "stun::server", "Starts the stun server"
recipe            "stun::purge",  "Stops the stun server and deletes all its files"

%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

depends "kagent"
depends "java"

attribute "stun/group",
          :description => "group parameter value",
          :type => "string"

attribute "stun/user",
          :description => "user parameter value",
          :type => "string"

attribute "stun/dir",
          :description => "Base directory for stun installation (default: '/srv')",
	  :type => "string"

attribute "java/jdk_version",
          :description => "Version of Java to use (e.g., '7' or '8')",
          :type => "string"

attribute "stun/id",
          :description => "id for the stun instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "stun/seed",
          :description => "seed for the dela instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "stun/log_level",
          :description => "Default: WARN. Can be INFO or DEBUG or TRACE or ERROR.",
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