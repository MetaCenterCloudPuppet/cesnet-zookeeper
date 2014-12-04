class zookeeper::service {
  service { $zookeeper::daemon:
    ensure    => 'running',
    enable    => true,
  }
}
