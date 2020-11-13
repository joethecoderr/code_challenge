require 'active_record'
require 'yaml'

dbconfig = YAML::load_file(File.join(__dir__, '../config/database.yml'))["development"]
ActiveRecord::Base.establish_connection(adapter: "mysql2", :host => dbconfig['hostname'], :username => dbconfig['username'], :password => dbconfig['password'], :database => dbconfig['database'])

class CreateVisitsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |table|
      table.string :evid
      table.string :vendor_site_id
      table.string :vendor_visit_id
      table.string :visit_ip
      table.string :vendor_visitor_id
    end
  end
end

CreateVisitsTable.migrate(:up)