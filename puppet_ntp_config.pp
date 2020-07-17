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
