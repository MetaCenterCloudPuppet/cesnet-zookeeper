# == Class zookeeper::params
#
# This class is meant to be called from zookeeper.
# It sets variables according to platform.
#
class zookeeper::params {
  case "${::osfamily}-${::operatingsystem}" {
    /RedHat-Fedora/: {
      $packages = {'zookeeper' => { ensure => '3.4.5+cdh5.3.3+84-1.cdh5.3.3.p0.8~wheezy-cdh5.3.3' }
      $daemon = 'zookeeper'
      $confdir = '/etc/zookeeper'
      $datadir = '/var/lib/zookeeper/data'
    }
    /Debian|RedHat/: {
      $packages = [ 'zookeeper-server' ]
      $daemon = 'zookeeper-server'
      $confdir = '/etc/zookeeper/conf'
      $datadir = '/var/lib/zookeeper'
    }
    default: {
      fail("${::osfamily} (${::operatingsystem}) not supported")
    }
  }
}
