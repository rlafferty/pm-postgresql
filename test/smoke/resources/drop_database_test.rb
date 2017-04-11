# # encoding: utf-8

# Inspec test for resource create_database in pm-postgresql

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

database_name = 'my_stuff'

describe service('postgresql') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

sql = postgres_session('postgres', 'supersecret')

describe sql.query("select datname from pg_database where datname = '#{database_name}'") do
  its(:lines) { should_not eq ["#{database_name}"] }
end
