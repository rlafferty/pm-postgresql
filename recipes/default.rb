#
# Cookbook:: pm-postgresql
# Recipe:: default
#
# Copyright:: 2017, PhishMe, All Rights Reserved.

log 'default recipe included' do
  message 'Include either pm-postgresql::server or pm-postgresql::client.'
  level :info
end
