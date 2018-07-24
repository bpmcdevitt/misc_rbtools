#!/usr/bin/env ruby

require 'twitter'
# im using this secret file to hold the apps key, secret, access token, and access token secret
load './secret'

class TwitterFollowerLookup
  def initialize(username, consumer_key, consumer_secret, auth_token, auth_secret)
    @username = username
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @auth_token = auth_token
    @auth_secret = auth_secret
  end

  def client(consumer_key, consumer_secret, access_token, access_token_secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = consumer_key
      config.consumer_secret = consumer_secret
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end

  # handles the main api call, and also handles rate limiting, just let it sleep for 15 min its ok!
  def get_followers
    get_followers = self.client.followers(self.username)
    begin
      get_followers.to_a
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 min but if you retry
      # any sooner, it will almost certaintly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

  def follower_names
    follower_names = self.get_followers.each do |follower|
      follower.name
    end
  end

  def save_to_file(filename, data_to_write)
    File.open(filename, 'w') do |file|
      file.write(data_to_write)
    end
  end

end
# testing
#
tw = TwitterFollowerLookup.new('bpmcdevitt', CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
puts tw.username
#tw = TwitterFollowerLookup.new('bpmcdevitt', CONSUMER_KEY, CONSUMER_SECRET, ACCESS_TOKEN, ACCESS_TOKEN_SECRET)
#puts tw.username
#puts tw.consumer_key
#puts tw.auth_token
#puts tw.auth_secret

#tw.save_to_file('/tmp/testing_twitter_follower.txt', tw.follower_names)
