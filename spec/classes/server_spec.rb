require 'spec_helper'

describe 'zookeeper::server::config', :type => 'class' do
  $test_os.each do |facts|
    os = facts['operatingsystem']
    path = $test_config_dir[os]
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }
      it { should contain_file(path + '/jaas.conf') }
      it { should contain_file(path + '/java.env') }
      it { should contain_file(path + '/zoo.cfg') }
    end
  end
end

describe 'zookeeper::server' do
  $test_os.each do |facts|
    os = facts['operatingsystem']
    path = $test_config_dir[os]
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('zookeeper::params') }
      it { is_expected.to contain_class('zookeeper::server::install').that_comes_before('zookeeper::server::config') }
      it { is_expected.to contain_class('zookeeper::server::config') }
      it { is_expected.to contain_class('zookeeper::server::service').that_subscribes_to('zookeeper::server::config') }
    end
  end
end
