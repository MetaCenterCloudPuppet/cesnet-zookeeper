# == Class zookeeper::common::postinstall
#
# Preparation steps after installation. It switches zookeeper-conf alternative, if enabled.
#
class zookeeper::common::postinstall {
  ::hadoop_lib::postinstall{'zookeeper':
    alternatives => $::zookeeper::alternatives,
  }
}
