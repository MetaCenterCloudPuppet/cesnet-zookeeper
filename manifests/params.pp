# == Class zookeeper::params
#
# Zookeeper module parameters.
# It sets variables according to platform.
#
class zookeeper::params {
  case "${::osfamily}-${::operatingsystem}" {
    /RedHat-Fedora/: {
      $packages = {
        'client' => [ 'zookeeper' ],
        'server' => [ 'zookeeper' ],
      }
      $daemon = 'zookeeper'
      $confdir = '/etc/zookeeper'
      $datadir = '/var/lib/zookeeper/data'
    }
    /Debian|RedHat/: {
      $packages = {
        'client' => [ 'zookeeper' ],
        'server' => [ 'zookeeper-server' ],
      }
      $daemon = 'zookeeper-server'
      $confdir = '/etc/zookeeper/conf'
      $datadir = '/var/lib/zookeeper'
    }
    default: {
      fail("${::osfamily} (${::operatingsystem}) not supported")
    }
  }
}
