#
# Cookbook:: virtualbox
# Recipe:: default
#
package node['virtualbox']['dependencies']

kernel_headers = node['virtualbox']['kernel_headers']
os_version = node['os_version'].split('.')
arch = os_version.pop
version = os_version.join('.')
package kernel_headers do
  arch arch
  version version
end

yum_repository 'virtualbox' do
  description 'Oracle Linux / RHEL / CentOS-$releasever / $basearch - VirtualBox'
  baseurl 'http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch'
  enabled true
  gpgcheck true
  repo_gpgcheck true
  gpgkey 'https://www.virtualbox.org/download/oracle_vbox.asc'
end

package node['virtualbox']['package']

node['virtualbox']['services'].each do |svc|
  service svc do
    action [:enable, :start]
  end
end
