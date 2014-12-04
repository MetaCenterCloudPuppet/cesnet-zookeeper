# == Class zookeeper::install
#
# Installs zookeeper node.
#
class zookeeper::install {
  include stdlib

  ensure_packages($zookeeper::packages)
}
