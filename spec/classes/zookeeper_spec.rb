require 'spec_helper'

# separated classes not supported
#describe 'zookeeper::config', :type => 'class' do
#  $test_os.each do |facts|
#    os = facts['operatingsystem']
#    path = $test_config_dir[os]
#
#    context "on #{os}" do
#      let(:facts) do
#        facts
#      end
#      it { should compile.with_all_deps }
#      it { should contain_file(path + '/zoo.cfg') }
#    end
#  end
#end

describe 'zookeeper', :type => 'class' do
  let(:params) { {:realm => ''} }

  $test_os.each do |facts|
    os = facts['operatingsystem']
    path = $test_config_dir[os]
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }
      it { should contain_class('zookeeper::install') }
      it { should contain_class('zookeeper::config') }
      it { should contain_class('zookeeper::service') }

      it { should contain_file(path + '/zoo.cfg') }
    end
  end
end
