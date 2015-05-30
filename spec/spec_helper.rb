require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

$test_os=[{
    'osfamily' => 'Debian',
    'operatingsystem' => 'Debian',
    'operatingsystemrelease' => ['7']
  }, {
    'osfamily' => 'Debian',
    'operatingsystem' => 'Ubuntu',
    'operatingsystemrelease' => ['14.04']
  }]

$test_config_dir={
  'Debian' => '/etc/zookeeper/conf',
  'Fedora' => '/etc/zookeeper',
  'Ubuntu' => '/etc/zookeeper/conf',
}
