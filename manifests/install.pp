# == Class zookeeper::install
#
# Installs zookeeper node.
#
class zookeeper::install {
  include ::stdlib

  if $zookeeper::preinstall_pinned_zookeeper {
      package {'zookeeper':
        ensure => '3.4.5+cdh5.3.3+84-1.cdh5.3.3.p0.8~wheezy-cdh5.3.3',
        before => Package[$zookeeper::packages]
      }
  }

  ensure_packages($zookeeper::packages)

  ::hadoop_lib::postinstall{ 'zookeeper':
    alternatives => $::zookeeper::alternatives,
  }
  Package[$zookeeper::packages] -> ::Hadoop_lib::Postinstall['zookeeper']
}
