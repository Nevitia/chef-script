user node['test_cookbook']['local_username'].to_s do
  password node['test_cookbook']['local_password'].to_s
end


group node['test_cookbook']['user_group'].to_s do
  action :modify
  members node['test_cookbook']['local_username'].to_s
  append true
end


directory 'C:\share' do
  action :create
end

batch 'add_perm' do
  code 'icacls "C:\share" /grant disk:(OI)(CI)F'
end

batch 'share_and_add_perm' do
  code 'net share share=C:\share /grant:disk,FULL'
  returns [0, 2]
end


batch 'create_diskT' do
  code 'net use T: \\\CLI-CHEF\share /SAVECRED'
end


