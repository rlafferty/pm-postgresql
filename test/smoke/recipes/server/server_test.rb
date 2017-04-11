# # encoding: utf-8

# Inspec test for recipe pm-postgresql::server

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('postgresql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

sql = postgres_session('postgres', 'supersecret')

describe sql.query("select datname from pg_database where datname = 'postgres'") do
  its(:lines) { should eq ['postgres'] }
end
