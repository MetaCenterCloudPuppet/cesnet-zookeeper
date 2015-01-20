# == Class zookeeper::params
#
# This class is meant to be called from zookeeper.
# It sets variables according to platform.
#
class zookeeper::params {
  case $::osfamily {
    'RedHat': {
      $alternatives = undef
      $packages = [ 'zookeeper' ]
      $daemon = 'zookeeper'
      $confdir = '/etc/zookeeper'
      $datadir = '/var/lib/zookeeper/data'
    }
    'Debian': {
      $alternatives = 'cluster'
      $packages = [ 'zookeeper-server' ]
      $daemon = 'zookeeper-server'
      $confdir = '/etc/zookeeper/conf'
      $datadir = '/var/lib/zookeeper'
    }
    default: {
      fail("${::osfamily} (${::operatingsystem}) not supported")
    }
  }

  $hostnames = undef

  $features = {
  }
}
