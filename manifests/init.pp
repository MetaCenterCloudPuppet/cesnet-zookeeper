# == Class: zookeeper
#
# Setup Zookeeper Cluster.
#
class zookeeper (
  $hostnames = undef,
  $alternatives = '::default',
  $myid = undef,
  $properties = undef,
  $realm = '',
) inherits zookeeper::params {
  include ::stdlib

  if !$myid {
    if $hostnames {
      $_myid = array_search($hostnames, $::fqdn)
    } else {
      $_myid = undef
    }
  } else {
    $_myid = $myid
  }
  notice("myid: ${_myid}")

  if !$_myid or $_myid == 0 {
    notice("Missing myid and zookeeper server ${::fqdn} not in zookeeper::hostnames list.")
  }

  if $realm and $realm != '' {
    $sec_properties = {
      'java.security.auth.login.config' => "${zookeeper::confdir}/jaas.conf",
      'zookeeper.security.auth_to_local' => "
RULE:[2:\$1;\$2@\$0](^jhs;.*@${realm}$)s/^.*$/mapred/
RULE:[2:\$1;\$2@\$0](^[ndjs]n;.*@${realm}$)s/^.*$/hdfs/
RULE:[2:\$1;\$2@\$0](^[rn]m;.*@${realm}$)s/^.*$/yarn/
RULE:[2:\$1;\$2@\$0](^hbase;.*@${realm}$)s/^.*$/hbase/
RULE:[2:\$1;\$2@\$0](^hive;.*@${realm}$)s/^.*$/hive/
RULE:[2:\$1;\$2@\$0](^hue;.*@${realm}$)s/^.*$/hue/
RULE:[2:\$1;\$2@\$0](^tomcat;.*@${realm}$)s/^.*$/tomcat/
RULE:[2:\$1;\$2@\$0](^zookeeper;.*@${realm}$)s/^.*$/zookeeper/
RULE:[2:\$1;\$2@\$0](^HTTP;.*@${realm}$)s/^.*$/HTTP/
DEFAULT
",
    }
  } else {
    $sec_properties = {}
  }

  $_properties = merge($sec_properties, $properties)

  include ::zookeeper::install
  include ::zookeeper::config
  include ::zookeeper::service

  Class['zookeeper::install'] ->
  Class['zookeeper::config'] ~>
  Class['zookeeper::service'] ->
  Class['zookeeper']
}
