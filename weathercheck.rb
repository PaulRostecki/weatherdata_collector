require 'net/http'
require 'json'
require 'csv'

config = File.read('config.json')
config = JSON.parse(config)

samples = config['samplenum'].to_i
timer = config['samplefreq'].to_f

url = "https://api.openweathermap.org/data/2.5/weather?q=#{config['city']}&exclude=hourly,daily&lang=en&appid=#{config['api']}"
uri = URI(url)

headers = ["date","hour","temperature","perceptible temperature","weather","humidity","wind speed"]

CSV.open('weather.csv', 'a+') do |row|
  row << headers
end

cond = 0

while cond < samples
  response = Net::HTTP.get(uri)
  JSON.parse(response)

  response = Net::HTTP.get(uri)
  response = JSON.parse(response)

  weather_desc = response['weather'][0]['description']
  temp = response['main']['temp'].to_i - 273
  temp_feels = response['main']['feels_like'].to_i - 273
  humidity = response['main']['humidity'].to_s + '%'
  wind_speed = response['wind']['speed']

  time = Time.now
  date = time.strftime("%d/%m/%Y")
  hour = time.strftime("%k:%M")

  data = ["#{date}","#{hour}","#{temp}","#{temp_feels}","#{weather_desc}","#{humidity}","#{wind_speed}"]

  CSV.open('weather.csv', 'a+') do |row|
    row << data
  end

  cond += 1
  sleep(timer*3600)
end
