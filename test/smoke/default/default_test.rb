# encoding: utf-8

# Inspec test for recipe virtualbox::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
#
package = 'VirtualBox-5.1'
services = %w(
  vboxdrv
  vboxautostart-service
  vboxballoonctrl-service
  vboxweb-service
)

case os[:family]
when 'redhat'
  describe yum.repo 'virtualbox' do
    it { should exist }
    it { should be_enabled }
  end
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
