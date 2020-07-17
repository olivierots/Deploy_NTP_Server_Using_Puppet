=== puppet_refresher ===
```
simple ntp puppet code to install, configure and start the ntp services on the managed agents 
```
=== How does puppet work ===
```
- Puppet can define infrastructure as code, manage multiple servers and enforce system configuration. It is used to
configure, manage, deploy, and orchestrate various applications and services across the whole infrastructure of an organization
- Puppet master is responsible for maintaning configs in the form of puppet code. master node can only be Linux
puppet agents is target machines, checks in regularly with the master node every 1800 secs known as pull config (poll update)
communication between master and slaves is through https & valid signed certificates on port 8140
no need to create complex scripts to confugure 1000s of hosts
site.pp is the first file Agents look for after establishing a communication connection with Puppet Master
node definitions are blocks of puppet codes that will only be included in matching nodes catalogues
puppet language files are called manifests, all the puppet code files with .pp extension should reside in the manifest dir 
puppet classes: collection of pupept resources bundled together as a single unit, classes are defined first then declared to 
be used in the puppet code
```
=== useful commands ===
```
facter : find in-built resources that can be used in Puppet codes
puppet parser validate <your .pp file> : check for syntax errors
puppet agent -tv --noop : smoke test (used on puppet agents)
puppet agent -tv : retrieve new catalogues from the puppet-master (used on puppet agents)
puppetserver ca list --all: list signed & unsigned certs from the master node. find agents managed by the master
puppetserver ca sign --certname <agent_hostname> : sign a cert. from puppet master
puppet describe <package> or <service> | more : find the attributes to be used in the code
```
=== Demo ===
```
[root@puppetmaster ~]# puppetserver ca list --all
Signed Certificates:
    puppetmaster.example.com        (SHA256)  4A:BB:4F:19:F7:A2:76:FB:4A:58:84:30:E6:4B:A2:9E:C6:CB:35:4E:38:FF:0D:8B:0F:60:07:4B:60:44:46:78 alt names: ["DNS:puppet", "DNS:puppetmaster.example.com"]        authorization extensions: [pp_cli_auth: true]
    puppetagent01.example.com       (SHA256)  F7:9B:78:42:FB:AC:86:83:10:CC:DB:09:B9:52:07:3B:B6:7C:5D:B9:75:76:77:BD:26:3C:0D:57:1B:37:5A:9B
    puppetagent02.example.com       (SHA256)  46:62:FE:62:EA:A2:8F:C6:67:7A:FF:C1:2E:98:E3:D3:E8:84:02:ED:73:3F:3C:A1:DA:1E:55:9B:67:21:77:9B

[root@puppetagent01 ~]# puppet agent -tv --noop  
Info: Using configured environment 'production'
Info: Retrieving pluginfacts
Info: Retrieving plugin
Info: Retrieving locales
Info: Applying configuration version '1594954250'
Notice: /Stage[main]/Ntpdemo/Package[ntp]/ensure: current_value 'purged', should be 'present' (noop)
Notice: /Stage[main]/Ntpdemo/File[/etc/ntp.conf]/ensure: current_value 'absent', should be 'present' (noop)
Notice: /Stage[main]/Ntpdemo/Service[ntpd]/ensure: current_value 'stopped', should be 'running' (noop)
Info: /Stage[main]/Ntpdemo/Service[ntpd]: Unscheduling refresh on Service[ntpd]
Notice: Class[Ntpdemo]: Would have triggered 'refresh' from 3 events
Notice: Stage[main]: Would have triggered 'refresh' from 1 event
Notice: Applied catalog in 0.20 seconds

[root@puppetmaster ~]# puppetserver ca sign --certname puppetagent01.example.com
Successfully signed certificate request for puppetagent01.example.com
```
