case node['platform']
when 'centos'
  default['virtualbox']['dependencies'] = %w(gcc make)
  default['virtualbox']['kernel_headers'] = 'kernel-devel'
end

default['virtualbox']['version'] = '5.1'
default['virtualbox']['package'] = "VirtualBox-#{node['virtualbox']['version']}"

default['virtualbox']['services'] = %w(
  vboxdrv
  vboxautostart-service
  vboxballoonctrl-service
  vboxweb-service
)
