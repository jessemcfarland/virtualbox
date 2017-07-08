# encoding: utf-8

# Inspec test for recipe virtualbox::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

dependencies = %W(gcc make kernel-devel)
repo = '/etc/yum.repos.d/virtualbox.repo'
package = 'VirtualBox-5.1'
services = %w(
  vboxdrv
  vboxautostart-service
  vboxballoonctrl-service
  vboxweb-service
)

dependencies.each do |pkg|
  describe package pkg do
    it { should be_installed }
  end
end

describe file repo do
  it { should be_file }
  its('content') { should include '[virtualbox]' }
end

describe package package do
  it { should be_installed }
end

services.each do |svc|
  describe service svc do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end
