# # encoding: utf-8

# Inspec test for recipe pm-postgresql::client

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

postgres_version = attribute('postgres_version', default: nil, description: 'PostgreSQL installed version by default')

if postgres_version.nil?
  # Default values per platform/version
  case os[:family]
  when 'debian'
    case os[:release]
    # Ubuntu versions
    when '14.04'
      postgres_version = '9.3'

    when '16.04'
      postgres_version = '9.5'
    end
  end
end

describe command('/usr/bin/psql --help') do
  its('exit_status') { should eq 0 }
end

describe command('/usr/bin/psql -V') do
  its('stdout') { should match(/psql \(PostgreSQL\) #{postgres_version}/) }
  its('exit_status') { should eq 0 }
end
