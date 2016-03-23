template 'freetds.conf' do
  case node[:platform]
  when 'centos','redhat','fedora','amazon'
    path "/etc/freetds.conf"
  when 'debian','ubuntu'
    path "/etc/freetds/freetds.conf"
  end
  source 'freetds.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end