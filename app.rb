require 'sinatra'
require 'json'
require 'httparty'

configure do 
  if ENV.key?("BACKEND_URL")
    set :backendURL, ENV["BACKEND_URL"]
  else
    set :backendURL, "http://localhost:9292"
  end
end

get "/" do
    response = HTTParty.get(settings.backendURL + "/items")
    @items = JSON.parse(response.body)
    erb :index
end

get '/env' do
    ret = ""
    ENV.keys.each do |k|
        ret += "<b>#{k}</b>: #{ENV[k]}<br />"
    end

    return ret
end