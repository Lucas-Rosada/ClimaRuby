require 'sinatra'
require 'httparty'
require 'uri'
require 'dotenv/load' 

get '/' do
  erb :index
end

post '/weather' do
  city = params[:city]
  api_key = ENV['WEATHER_API_KEY']  # Coloque sua key aqui
  encoded_city = URI.encode_www_form_component(city)

  response = HTTParty.get("http://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{encoded_city}")

  if response.success?
    @weather = response.parsed_response
    erb :weather
  else
    @error = "Cidade não encontrada ou erro ao acessar a API."
    erb :index
  end
end
