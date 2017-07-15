#
# Cookbook:: virtualbox
# Spec:: default
#
require 'spec_helper'

shared_examples 'virtualbox_test' do |platform, metadata|
  context "when run on #{platform} #{metadata['version']}" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: platform, version: metadata['version'])
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    package = metadata['package']
    it "installs #{package}" do
      expect(chef_run).to install_package package
    end

    metadata['services'].each do |svc|
      it 'enables VirtualBox services' do
        expect(chef_run).to enable_service svc
      end

      it 'starts VirtualBox services' do
        expect(chef_run).to start_service svc
      end
    end
  end
end

describe 'virtualbox::default' do
  platforms = {
    'centos' => {
      'version' => '7.3.1611',
      'package' => 'VirtualBox-5.1',
      'services' => %w(
        vboxdrv
        vboxautostart-service
        vboxballoonctrl-service
        vboxweb-service
      )
    }
  }

  platforms.each do |platform, metadata|
    include_examples 'virtualbox_test', platform, metadata
  end
end
