pg_database 'my_stuff' do
  owner 'postgres'
  action :drop
end
