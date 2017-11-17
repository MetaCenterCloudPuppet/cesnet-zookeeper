# Class: zookeeper::client
#
# Zookeeper client
#
class zookeeper::client {
  include ::zookeeper::client::install
  include ::zookeeper::client::config

  Class['zookeeper::client::install']
  -> Class['zookeeper::client::config']
  -> Class['zookeeper::client']
}
