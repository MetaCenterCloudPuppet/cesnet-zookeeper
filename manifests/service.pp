# Class: zookeeper::service
#
# Launch zookeeper service.
#
class zookeeper::service {
  service { $zookeeper::daemon:
    ensure => 'running',
    enable => true,
  }
}
