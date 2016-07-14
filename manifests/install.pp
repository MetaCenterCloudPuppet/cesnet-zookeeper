# == Class zookeeper::install
#
# Installs zookeeper node.
#
class zookeeper::install {
  include ::stdlib

  ensure_packages($zookeeper::packages)

  ::hadoop_lib::postinstall{ 'zookeeper':
    alternatives => $::zookeeper::alternatives,
  }
  Package[$zookeeper::packages] -> ::Hadoop_lib::Postinstall['zookeeper']
}
