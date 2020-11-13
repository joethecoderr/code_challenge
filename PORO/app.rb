
require 'httparty'
require_relative 'models/Visits'
require_relative 'models/Pageviews'
require 'json'

visit = Visit.new()
visit.save_data_from_api

pageview = Pageview.new()
pageview.save_data_from_api

