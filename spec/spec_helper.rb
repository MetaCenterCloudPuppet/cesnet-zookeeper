require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

require 'simplecov'
require 'simplecov-console'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
end

$test_os=[{
    'osfamily' => 'Debian',
    'operatingsystem' => 'Debian',
    'operatingsystemrelease' => ['7']
  }, {
    'osfamily' => 'Debian',
    'operatingsystem' => 'Ubuntu',
    'operatingsystemrelease' => ['14.04']
  }, {
    'osfamily' => 'RedHat',
    'operatingsystem' => 'RedHat',
    'operatingsystemrelease' => ['6']
  }, {
    'osfamily' => 'RedHat',
    'operatingsystem' => 'CentOS',
    'operatingsystemrelease' => ['7']
  }]

$test_config_dir={
  'CentOS' => '/etc/zookeeper/conf',
  'Debian' => '/etc/zookeeper/conf',
  'Fedora' => '/etc/zookeeper',
  'RedHat' => '/etc/zookeeper/conf',
  'Ubuntu' => '/etc/zookeeper/conf',
}
