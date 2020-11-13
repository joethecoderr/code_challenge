require 'active_record'
require 'yaml'

dbconfig = YAML::load_file(File.join(__dir__, '../config/database.yml'))["development"]
ActiveRecord::Base.establish_connection(adapter: "mysql2", :host => dbconfig['hostname'], :username => dbconfig['username'], :password => dbconfig['password'], :database => dbconfig['database'])

class CreatePageviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pageviews do |table|
      table.bigint :visit_id
      table.string :title
      table.string :position
      table.string :url
      table.string :time_spent
      table.decimal :timestamp, precision: 14, scale: 3
    end
  end
end

CreatePageviewsTable.migrate(:up)