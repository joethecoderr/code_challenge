require 'active_record'
require 'yaml'
require 'httparty'

dbconfig = YAML::load_file(File.join(__dir__, '../config/database.yml'))["development"]
ActiveRecord::Base.establish_connection(adapter: "mysql2", :host => dbconfig['hostname'], :username => dbconfig['username'], :password => dbconfig['password'], :database => dbconfig['database'])

class Visit < ActiveRecord::Base


    @evid
    @vendor_site_id
    @vendor_visit_id
    @visit_ip
    @vendor_visitor_id

    def inititiliazer()
    end
    def save_data_from_api
      response = HTTParty.get('http://localhost:4567')
      visits_data =JSON.parse(response)
      visits = visits_data.map do |line|
        v = Visit.new
        v.evid = v.validate_referrer_name(line['referrerName'])
        v.vendor_site_id = line['idSite']
        v.vendor_visit_id = line['id_visit']
        v.visit_ip = line['visitIp']
        v.vendor_visitor_id = line['visitorId']
        v.save
      end
    end
    def validate_referrer_name(referrerName)
        referrerName = referrerName.gsub("evid_", "")
        if referrerName.match(/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/)
            return referrerName
        else
            nil
        end
    end
end