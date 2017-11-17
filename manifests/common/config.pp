# == Class: zookeeper::common:config
#
# Zookeeper common configuration.
#
class zookeeper::common::config {
  if $zookeeper::realm and $zookeeper::realm!= '' {
    file { "${zookeeper::confdir}/jaas.conf":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('zookeeper/jaas.conf.erb'),
    }
  } else {
    file { "${zookeeper::confdir}/jaas.conf":
      ensure => 'absent',
    }
  }

  if $zookeeper::_properties {
    file { "${zookeeper::confdir}/java.env":
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('zookeeper/java.env.erb'),
    }
  } else {
    file { "${zookeeper::confdir}/java.env":
      ensure => 'absent',
    }
  }
}
