describe 'cvs_wrapper::environment' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes dependencies recipe' do
    expect(chef_run).to include_recipe("cvs_wrapper::dependencies")
  end

  it 'includes ruby recipe' do
    expect(chef_run).to include_recipe("cvs_wrapper::ruby")
  end
end
