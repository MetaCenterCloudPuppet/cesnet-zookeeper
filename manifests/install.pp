# == Class zookeeper::install
#
# Installs zookeeper node.
#
class zookeeper::install {
  include ::stdlib

  $confname = $zookeeper::alternatives

  ensure_packages($zookeeper::packages)

  if $confname {
    exec { 'zookeeper-copy-config':
      command => "cp -a ${zookeeper::confdir}/ /etc/zookeeper/conf.${confname}",
      path    => '/sbin:/usr/sbin:/bin:/usr/bin',
      creates => "/etc/zookeeper/conf.${confname}",
    }
    ->
    alternative_entry{"/etc/zookeeper/conf.${confname}":
      altlink  => '/etc/zookeeper/conf',
      altname  => 'zookeeper-conf',
      priority => 50,
    }
    ->
    alternatives{'zookeeper-conf':
      path => "/etc/zookeeper/conf.${confname}",
    }

    Package[$zookeeper::packages] -> Exec['zookeeper-copy-config']
  }
}
