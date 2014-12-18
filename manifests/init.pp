# == Class: zookeeper
#
# Setup Zookeeper Cluster.
#
# === Parameters
#
# [*hostnames*] (nil)
#   Array of zookeeper nodes hostnames.
#
# [*realm*] (required)
#   Kerberos realm. Required parameter, empty string disables Kerberos authentication.
#   To enable security, there are required:
#   * configured Kerberos (/etc/krb5.conf, /etc/krb5.keytab)
#   * /etc/security/keytab/zookeeper.service.keytab (on zookeeper nodes)
#
class zookeeper (
  $hostnames = $params::hostnames,
  $realm,
) inherits zookeeper::params {
  include 'zookeeper::install'
  include 'zookeeper::config'
  include 'zookeeper::service'

  Class['zookeeper::install'] ->
  Class['zookeeper::config'] ~>
  Class['zookeeper::service'] ->
  Class['zookeeper']
}
