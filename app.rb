require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "3ad1cca93b38c82083ddbc0ae35aec28"

url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c1503f89142e4bbaba95e473e105ba3e"
news = HTTParty.get(url).parsed_response.to_hash

forecast = ForecastIO.forecast(42.0574063,-87.6722787).to_hash

# puts forecast

# puts news

get "/" do
  
#     results = Geocoder.search(params["location"])
#     lat_long = results.first.coordinates # => [lat, long]
#     lat = "#{lat_long [0]}"
#     long = "#{lat_long [1]}"
#     @forecast = ForecastIO.forecast("#{lat_long[0]}","#{lat_long[1]}").to_hash
#    "#{lat_long[0]} #{lat_long[1]}"
   
    
    view "ask"
end

get "/news" do
    
    results = Geocoder.search(params["location"])
    
    @lat_long = results.first.coordinates # => [lat, long]
    @location = results.first.city

    # Define the lat and long
    @lat = "#{lat_long [0]}"
    @long = "#{lat_long [1]}"

    # Results from Geocoder
    @forecast = ForecastIO.forecast("#{lat}" , "#{long}").to_hash
    @current_temperature = forecast["currently"]["temperature"]
    @conditions = forecast["currently"]["summary"]

    puts "In #{location}, it is currently #{current_temperature} and #{conditions}"

    # high_temperature = forecast["daily"]["data"][0]["temperatureHigh"]
    # puts high_temperature
    # puts forecast["daily"]["data"][1]["temperatureHigh"]
    # puts forecast["daily"]["data"][2]["temperatureHigh"]
    
    for day_forecast in forecast["daily"]["data"]
    puts "A high temperature of #{day["temperatureHigh"]} and #{day["summary"]}."
    end


    view "news"
end