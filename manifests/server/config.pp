# == Class: zookeeper::server:::config
#
# Zookeeper server configuration.
#
class zookeeper::server::config {
  contain zookeeper::common::config

  notice("myid: ${::zookeeper::_myid}")
  if !$zookeeper::_myid or $zookeeper::_myid == 0 {
    notice("Missing myid and zookeeper server ${::fqdn} not in zookeeper::hostnames list.")
  }

  file { "${zookeeper::confdir}/zoo.cfg":
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('zookeeper/zoo.cfg.erb'),
  }

  $keytab = '/etc/security/keytab/zookeeper.service.keytab'

  if $zookeeper::realm and $zookeeper::realm!= '' {
    file { $keytab:
      owner => 'zookeeper',
      group => 'zookeeper',
      mode  => '0400',
    }
  }

  # always create myid file explicitly
  # (workaround ugly bug in BigTop)
  if $zookeeper::_myid and $zookeeper::_myid != 0 {
    file { "${zookeeper::datadir}/myid":
      owner   => 'zookeeper',
      group   => 'zookeeper',
      mode    => '0644',
      replace => false,
      # lint:ignore:only_variable_string
      # (needed to convert integer to string)
      content => "${::zookeeper::_myid}",
      # lint:endignore
    }
  }

  case "${::osfamily}-${::operatingsystem}" {
    /RedHat-Fedora/,default: {
    }
    /Debian|RedHat/: {
      if $zookeeper::_myid and $zookeeper::_myid != 0 {
        $args = "--myid ${::zookeeper::_myid}"
      } else {
        $args = ''
      }
      exec { 'zookeeper-init':
        command => "zookeeper-server-initialize ${args}",
        creates => "${zookeeper::datadir}/version-2",
        path    => '/sbin:/usr/sbin:/bin:/usr/bin',
        user    => 'zookeeper',
        require => [ File["${zookeeper::confdir}/zoo.cfg"], ],
      }
      if $zookeeper::_myid and $zookeeper::_myid != 0 {
        # try the proper init first
        Exec['zookeeper-init'] -> File["${zookeeper::datadir}/myid"]
      }

      if $zookeeper::realm and $zookeeper::realm != '' {
        File[$keytab] -> Exec['zookeeper-init']
        File["${zookeeper::confdir}/jaas.conf"] -> Exec['zookeeper-init']
        File["${zookeeper::confdir}/java.env"] -> Exec['zookeeper-init']
      }
    }
  }
}
