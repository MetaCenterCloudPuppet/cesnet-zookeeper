require 'spec_helper'

describe 'zookeeper::client::config', :type => 'class' do
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
    end
  end
end

describe 'zookeeper::client' do
  $test_os.each do |facts|
    os = facts['operatingsystem']
    path = $test_config_dir[os]
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('zookeeper::params') }
      it { is_expected.to contain_class('zookeeper::client::install').that_comes_before('zookeeper::client::config') }
      it { is_expected.to contain_class('zookeeper::client::config') }
      it { should contain_package('zookeeper').with_ensure('present') }
    end
  end
end
