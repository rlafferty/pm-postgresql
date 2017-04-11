resource_name :pg_database

property :database_name, String, name_property: true
property :template, String
property :encoding, String, default: 'UTF8'
property :tablespace, String
property :owner, String, default: 'postgres'

action :create do
  load_pg_gem

  unless already_exists?
    Chef::Log.info("#{@new_resource}: Create database \
    #{new_resource.database_name}")
    sql = "CREATE DATABASE \"#{new_resource.database_name}\""
    sql += " TEMPLATE = #{new_resource.template}" if new_resource.template
    sql += " TABLESPACE = #{new_resource.tablespace}" if new_resource.tablespace
    sql += " OWNER = \"#{new_resource.owner}\""
    Chef::Log.info("#{@new_resource}: Performing query [#{sql}]")
    db('postgres').query(sql)
    @new_resource.updated_by_last_action(true)
  end
end

action_class do
  def load_pg_gem
    Gem.clear_paths
    begin
      require 'pg'
    rescue LoadError
      Chef::Log.fatal('Could not load the required pg gem. ' \
      'Make sure to postgresql::ruby recipes is included in your runlist')
      raise
    end
  end

  def db(dbname = nil)
    close_client if @db
    host = 'localhost'
    port = 5432
    user = 'postgres'
    @db = ::PGconn.new(
      host: node['postgresql']['config']['listen_addresses'],
      port: node['postgresql']['config']['port'],
      dbname: dbname,
      user: user,
      password: node['postgresql']['password']['postgres']
    )
  end

  def already_exists?
    begin
      db_check = 'SELECT * FROM pg_database where '
      db_check += "datname = '#{@new_resource.database_name}'"
      ret = db('postgres').query(db_check).num_tuples != 0
    ensure
      close_client
    end
    ret
  end

  def close_client
    begin
      @db.close
    rescue
      nil
    end
    @db = nil
  end
end
