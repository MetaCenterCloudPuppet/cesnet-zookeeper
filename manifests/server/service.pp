# Class: zookeeper::server::service
#
# Launch zookeeper service.
#
class zookeeper::server::service {
  service { $zookeeper::daemon:
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
