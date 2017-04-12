# pm-postgresql Cookbook

The pm-postgresql Cookbook is a wrapper cookbook for the postgresql supermarket library cookbook that provides the to install and configure postgres client and server as well as providing custom resources to create and drop databases.

## Scope

This cookbook is concerned with postgres database, particularly those simple deployments for a single server. It does not address (yet) clustering.

## Requirements

- Chef 12.5 or higher
- Network accessible package repositories

## Platform Support

The following platforms have been tested with Test Kitchen:

```
|----------------+-----+-----+-----+
|                | 0.1 | 1.0 | 1.1 |
|----------------+-----+-----+-----+
| ubuntu-14.04   | X   | X   | X   |
|----------------+-----+-----+-----+
| ubuntu-16.04   | X   | X   | X   |
|----------------+-----+-----+-----+
```

## Cookbook Dependencies

-[postgresql](https://supermarket.chef.io/cookbooks/postgresql)

## Usage

Place a dependency on the pm-postgresql cookbook in your cookbook's metadata.rb (and Berksfile if leveraging berks)

```ruby
depends 'pm-postgresql', '~> 1.0.0', git: 'https://github.com/rlafferty/pm-nginx.git'
```

Then, in a recipe to install a postgres database server:

```ruby
include_recipe 'pm-postgresql::server'
```

Or to install the postgres database client:

```ruby
include_recipe 'pm-postgresql::client'
```

## Attributes

## Resources Overview

### pg_database

Used to create or drop a postgres database.

### Actions

- `create` - Create the postgres database (default)
- `crop` - Drop an existing postgres database

### Properties:

- `database_name` - (required) this is named parameter of the database you wish to take action on.
- `template` - (optional) a template to create the database from (used in :create)
- `encoding` - (optional) what encoding the database should have (used in :create)
- `tablespace` - (optional) what tablespace should be associated with the database (used in :create)
- `owner` - (default: postgres) who the owner of the database is (used in :create)

### Examples:

Create a database called 'my_stuff':

```ruby
pg_database 'my_stuff' do
  owner 'postgres'
end
```

Drop a database called 'my_stuff':

```ruby
pg_database 'my_stuff' do
  owner 'postgres'
  action :drop
end
```

## Frequently Asked Questions


## License

```text
Copyright:: 2009-2017 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
