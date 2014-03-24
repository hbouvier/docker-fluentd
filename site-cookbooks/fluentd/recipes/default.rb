#
fluentd_packages = ['libcurl4-openssl-dev']
fluentd_packages.each do |pkg|
  package pkg do
    action :install
  end
end

#
directories = ['/etc/td-agent', '/etc/td-agent/conf.d']
directories.each do |dir|
  directory dir do
    mode 0755
    action :create
  end
end

#
#template "/etc/td-agent/td-agent.conf" do
#    source "td-agent.conf.erb"
#    mode 0600
#end

#
template "/etc/td-agent/elasticsearch.conf.tpl" do
    source "elasticsearch.conf.tpl.erb"
    mode 0600
end