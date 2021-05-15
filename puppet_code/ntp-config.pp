node 'puppetagent01.example.com','puppetagent02.example.com' {
   include ntpdemo
}

node 'default' {
}
[root@puppetmaster manifests]# cat ntp-config.pp
# Definition of a class
class ntpdemo {

# Installing NTP package
package { "ntp":
  ensure => "present",
}

# configuring NTP config file
file { "/etc/ntp.conf":
  ensure => "present",
  content=> "server 0.centos.pool.ntp.org iburst\n",
}

# starting NTP service
service { "ntpd":
  ensure => "running",
}
}

