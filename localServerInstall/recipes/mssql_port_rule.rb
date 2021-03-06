include_recipe 'boxstarter::default'

boxstarter 'install SQL Server' do
  password node['test_cookbook']['chef_client_password']
  disable_reboots false
  code <<-EOH
$SQLArgs = '/SECURITYMODE=SQL ' +
  '/SAPWD="#{node['test_cookbook']['sa_password']}" ' +
  '/TCPENABLED=1'
[Environment]::SetEnvironmentVariable(
  "chocolateyInstallArguments",
  $SQLArgs,
  "Machine")
cinst mssqlserver2014express --force
  EOH
end

=begin
registry_key 'static_tcp_reg_key' do
  values [{ name: 'TcpPort', type: :string, data: node['test_cookbook']['port'].to_s },
          { name: 'TcpDynamicPorts', type: :string, data: '' }]
  recursive true
  notifies :restart, "service[#{service_name}]", :immediately
end
=end

windows_firewall_rule 'MSSQL' do
          localport node['test_cookbook']['port'].to_s
          protocol 'TCP'
          firewall_action :allow
end


