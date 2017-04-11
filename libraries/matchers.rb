if defined?(ChefSpec)
  ChefSpec.define_matcher :pg_database

  def create_pg_database(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:pg_database, :create, resource_name)
  end

  def drop_pg_database(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:pg_database, :drop, resource_name)
  end

end
