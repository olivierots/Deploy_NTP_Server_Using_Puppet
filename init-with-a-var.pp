class  ntpmodule {

# define variables
$timeserver = "server 0.centos.pool.ntp.org iburst\n"

# Installing NTP package
package { "ntp":
  ensure => "installed",
}

# configuring NTP config file
file { "/etc/ntp.conf":
  ensure => "present",
  content=> "$timeserver",
}

# starting NTP service
service { "ntpd":
  ensure => "running",
  enable => "true",
}

