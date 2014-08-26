describe 'cvs_wrapper::dependencies' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs thecon gem package' do
    expect(chef_run).to install_gem_package('thecon')
  end

  it 'installs hostsfile gem package' do
    expect(chef_run).to install_gem_package('hostsfile')
  end
end
