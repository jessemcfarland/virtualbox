#
# Cookbook:: virtualbox
# Recipe:: default
#
include_recipe 'build-essential::default'

case node['platform_family']
when 'rhel'
  yum_repository 'virtualbox' do
    description 'Oracle Linux / RHEL / CentOS-$releasever / $basearch - VirtualBox'
    baseurl 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
    enabled true
    gpgcheck true
    repo_gpgcheck true
    gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
  end

  # Install 'kernel-devel' for active kernel; virtualbox kernel module
  # compilation fails without it
  os_version = node['os_version'].split('.')
  arch = os_version.pop
  version = os_version.join('.')
  package 'kernel-devel' do
    arch arch
    version version
  end
end

package node['virtualbox']['package']

node['virtualbox']['services'].each do |svc|
  service svc do
    action [:enable, :start]
  end
end
