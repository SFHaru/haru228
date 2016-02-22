require 'faraday'
require 'json'
require_relative 'wth'

class Main
    API_KEY='45cbb8e6c6d8dcaec7c38783d118957e'

  attr_accessor :city_name  

  def initialize(city_name='Tokyo')
    @city_name=city_name
  end

  def weather
  	Weather.new(@city_name, conditions['main']['temp']).weather_info
  end

  def connection 
    @connection||= Faraday.new(url:'http://openweathermap.org') do |faraday|		
    faraday.request :url_encoded
    faraday.adapter Faraday.default_adapter 
    end
  end

  def conditions
    response ||= connection.get("/data/2.5/weather?q=#{@city_name.gsub('-','_')}&units=metric&appid=#{API_KEY}")
    @conditions=JSON.parse(response.body)
  end 
end 
city_name = gets.delete "\n"
main = Main.new(city_name)
puts main.weather