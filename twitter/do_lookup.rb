#!/usr/bin/env ruby
#
load 'secret'
require './twitter_follower_lookup.rb'

username = 'bpmcdevitt'
consumer_key = CONSUMER_KEY
consumer_secret = CONSUMER_SECRET
auth_token = ACCESS_TOKEN
auth_secret = ACCESS_TOKEN_SECRET

tw = TwitterFollowerLookup.new(username, consumer_key, consumer_secret, auth_token, auth_secret)

follower_usernames = tw.get_follower_usernames

follower_usernames.each do |username|
  puts username.name
end

