# Class: zookeeper::server
#
# Zookeeper node
#
class zookeeper::server {
  include ::zookeeper::server::install
  include ::zookeeper::server::config
  include ::zookeeper::server::service

  Class['zookeeper::server::install']
  -> Class['zookeeper::server::config']
  ~> Class['zookeeper::server::service']
  -> Class['zookeeper::server']
}
