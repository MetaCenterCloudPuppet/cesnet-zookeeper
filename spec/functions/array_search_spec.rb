require 'spec_helper'

describe 'array_search' do
  hosts=['host1', 'host2', 'host3']
  it { should run.with_params(hosts, 'host1').and_return(1) }
  it { should run.with_params(hosts, 'host2').and_return(2) }
  it { should run.with_params(hosts, 'host3').and_return(3) }
  it { should run.with_params(hosts, 'host4').and_return(0) }

  it { should run.with_params(['single'], 'single').and_return(1) }
  it { should run.with_params(['single'], 'host4').and_return(0) }
end
