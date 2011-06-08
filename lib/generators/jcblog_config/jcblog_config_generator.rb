require 'rails/generators/migration'
require 'rails/generators/active_record'
  class JcblogConfigGenerator < Rails::Generators::Base
    include Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    def self.next_migration_number(path)
      ActiveRecord::Generators::Base.next_migration_number(path)
    end

    def gen_migration
      migration_template 'schema.rb', 'db/migrate/jcblog_config'
    end
  end