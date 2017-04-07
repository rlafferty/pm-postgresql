#
# Cookbook:: pm-postgresql
# Recipe:: client
#
# Copyright:: 2017, PhishMe, All Rights Reserved.

%w(client ruby).each do |recipe|
  include_recipe "postgresql::#{recipe}"
end
