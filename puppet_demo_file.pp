file { "/var/tmp/tesfile":
  ensure => "present",
  owner  => "yogeshraheja",
  group  => "yogeshraheja",
  mode   => "0777",
  content => " Hello & welcome to Puppet :)\n ",
}
