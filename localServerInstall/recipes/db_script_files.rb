cookbook_file 'C:\temp\examinator.sql' do
  source 'examinator.sql'
  action :create
end

batch 'sql_server_install' do
code 'sqlcmd -S CLI-CHEF\SQLEXPRESS -i C:\temp\examinator.sql'
end

boxstarter 'install 7zip' do
  password node['test_cookbook']['chef_client_password']
  disable_reboots false
  code <<-EOH
	cinst 7zip 
  EOH
end

directory 'C:\temp' do
  action :create
end

cookbook_file 'C:\temp\diskt.zip' do
  source 'diskt.zip'
  action :create
end

batch 'unzip' do
  code '"C:\Program Files\7-zip\7z.exe" x C:\temp\diskt.zip -oC:\share -r -y'
end
