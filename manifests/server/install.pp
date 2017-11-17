# == Class zookeeper::server::install
#
# Zookeeper node instalilation.
#
class zookeeper::server::install {
  include ::stdlib
  include ::zookeeper::common::postinstall

  ensure_packages($zookeeper::packages['server'])
  Package[$zookeeper::packages['server']] -> ::Hadoop_lib::Postinstall['zookeeper']
}
