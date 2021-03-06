#
# Cookbook Name:: test_cookbook
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if (node['platform_family'] != 'windows')
	Chef::Application.fatal!('Attempted to install on an unsupported platform')
end

#include_recipe 'test_cookbook::mssql_port_rule'

include_recipe 'test_cookbook::user_dir_disk_share'

include_recipe 'test_cookbook::db_script_files'

reboot 'reboot_to_finish' do
  action :reboot_now
  delay_mins 5
end


