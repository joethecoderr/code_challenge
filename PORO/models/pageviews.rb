require 'active_record'
require 'yaml'
require 'httparty'

dbconfig = YAML::load_file(File.join(__dir__, '../config/database.yml'))["development"]
ActiveRecord::Base.establish_connection(adapter: "mysql2", :host => dbconfig['hostname'], :username => dbconfig['username'], :password => dbconfig['password'], :database => dbconfig['database'])

class Pageview < ActiveRecord::Base

    @url
    @title
    @time_spent
    @timestamp
    @position

    def inititiliazer()
    end
    def save_data_from_api
      response = HTTParty.get('http://localhost:4567')
      pageview_data =JSON.parse(response)
      pageviews = pageview_data.each_with_index.map do |line, index|
        pv = Pageview.new
        pv.visit_id = line['idVisit']
        pv.title = line['actionDetails'][index]['pageTitle']
        pv.position = 1
        pv.url = line['actionDetails'][index]['url']
        pv.time_spent = line['actionDetails'][index]['timeSpent']
        pv.timestamp = line['actionDetails'][index]['timestamp']
        pv.save
      end
    
      
    end

  
end