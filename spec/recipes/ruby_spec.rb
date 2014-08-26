describe 'cvs_wrapper::ruby' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes tar recipe' do
    expect(chef_run).to include_recipe("tar")
  end

  it 'includes ruby_install recipe' do
    expect(chef_run).to include_recipe("ruby_install")
  end

  it 'installs bzip2' do
    expect(chef_run).to install_package("bzip2")
  end

  it 'creates a link for the system ruby' do
    chef_run.node.set[:ruby_install][:default_ruby_base_path] = '/opt/rubies'
    chef_run.converge(described_recipe)
    expect(chef_run).to create_link("/opt/rubies/system")
  end

  it "triggers the creation of links for ruby binaries" do
    chef_run.node.set[:ruby_install][:default_ruby_base_path] = '/opt/rubies'
    chef_run.node.set[:system_ruby][:bin_path] = "/usr/local/bin"
    chef_run.converge(described_recipe)

    expect(chef_run).to run_ruby_block("link_ruby_binaries_to_system")
  end

  # A version using an updated ruby_install cookbook will include the matchers
end
