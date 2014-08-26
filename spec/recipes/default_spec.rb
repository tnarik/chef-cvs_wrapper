describe 'cvs_wrapper::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'creates system cvs_wrapper.sh' do
    expect(chef_run).to create_template("/etc/profile.d/cvs_wrapper.sh")
  end

  it 'includes environment recipe' do
    expect(chef_run).to include_recipe("cvs_wrapper::environment")
  end
end
