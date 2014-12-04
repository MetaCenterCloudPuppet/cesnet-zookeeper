# == Class: zookeeper
#
# Setup Zookeeper Cluster.
#
# === Parameters
#
# [*hostnames*] (nil)
#   Array of zookeeper nodes hostnames.
#
class zookeeper (
  $hostnames = $params::hostnames,
) inherits zookeeper::params {
  if $zookeeper::perform {
    include 'zookeeper::install'
    include 'zookeeper::config'
    include 'zookeeper::service'

    Class['zookeeper::install'] ->
    Class['zookeeper::config'] ~>
    Class['zookeeper::service'] ->
    Class['zookeeper']
  }
}
