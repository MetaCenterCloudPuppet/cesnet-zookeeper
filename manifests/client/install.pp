# == Class zookeeper::client::install
#
# Zookeeper client installation.
#
class zookeeper::client::install {
  include ::stdlib
  include ::zookeeper::common::postinstall

  ensure_packages($zookeeper::packages['client'])
  Package[$zookeeper::packages['client']] -> ::Hadoop_lib::Postinstall['zookeeper']
}
