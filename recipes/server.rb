#
# Cookbook:: pm-postgresql
# Recipe:: server
#
# Copyright:: 2017, PhishMe, All Rights Reserved.

%w(server).each do |recipe|
  include_recipe "postgresql::#{recipe}"
end
