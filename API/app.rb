require 'sinatra'
require 'json'

get '/' do
    
    file = File.open(File.join(__dir__,"./samples/api_response.json"))
    return file
end