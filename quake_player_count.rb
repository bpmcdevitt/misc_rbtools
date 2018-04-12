#!/usr/bin/env ruby
#

require 'net/http'
require 'json'

quake_id = '611500'
url = "https://api.steampowered.com/ISteamUserStats/GetNumberOfCurrentPlayers/v1/?appid=#{quake_id}"
uri = URI(url)
response = Net::HTTP.get(uri)
json_data = JSON.parse(response)

puts json_data['response']['player_count']
