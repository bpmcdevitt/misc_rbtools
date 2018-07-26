#!/usr/bin/env ruby
#
load 'secret'
require './twitter_follower_lookup.rb'

# set the username to the arg we pass the script
username = ARGV[0]
consumer_key = CONSUMER_KEY
consumer_secret = CONSUMER_SECRET
auth_token = ACCESS_TOKEN
auth_secret = ACCESS_TOKEN_SECRET

# make your client object
tw = TwitterFollowerLookup.new(username, consumer_key, consumer_secret, auth_token, auth_secret)

# get an array of follower names and save them to a file
follower_names = tw.follower_names
tw.save_to_file("/home/booboy/bin/mygit/misc_rbtools/twitter/data/followers/#{username}_followers.txt", follower_names)
