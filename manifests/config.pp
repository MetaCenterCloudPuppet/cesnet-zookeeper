class zookeeper::config {
  if $zookeeper::hostnames {
    $myid = array_search($zookeeper::hostnames, $::fqdn)
  } else {
    $myid = undef
  }
  notice("myid: ${myid}")

  if !$myid {
    notice("Missing myid! Zookeeper server $::fqdn not in zookeeper::hostnames list.")
  }

  file { "${zookeeper::confdir}/zoo.cfg":
    owner => 'root',
    group => 'root',
    mode  => '0644',
    content => template('zookeeper/zoo.cfg.erb'),
    alias => 'zoo-cfg',
  }

  case "${::osfamily}" {
    'RedHat': {
      if $myid {
        file { "${zookeeper::datadir}/myid":
          owner   => 'zookeeper',
          group   => 'zookeeper',
          mode    => '0644',
          replace => false,
          content => "${myid}",
        }
      }
    }
    'Debian': {
      if $myid {
        $args = "--myid ${myid}"
      } else {
        $args = ""
      }
      exec { "zookeeper-init":
        command => "zookeeper-server-initialize ${args}",
        creates => "${zookeeper::datadir}/version-2",
        path    => '/sbin:/usr/sbin:/bin:/usr/bin',
        user    => 'zookeeper',
        require => File['zoo-cfg'],
      }
    }
  }
}
