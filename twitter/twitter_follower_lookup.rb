#!/usr/bin/env ruby

require 'twitter'
require 'pry'

class TwitterFollowerLookup
  def initialize(username, consumer_key, consumer_secret, access_token, access_token_secret)
    @username = username
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @access_token = access_token
    @access_token_secret = access_token_secret
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = consumer_key
      config.consumer_secret = consumer_secret
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end

  # handles the main api call, and also handles rate limiting, just let it sleep for 15 min its ok!
  def get_follower_usernames
    get_follower_usernames = @client.followers(@username)
    begin
      get_follower_usernames.to_a
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 min but if you retry
      # any sooner, it will almost certaintly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

  # dont think this one works, havent tested yet.
  def follower_names
    follower_names = get_follower_usernames.map do |username|
      username.name
    end
  end

  def save_to_file(filename, data_to_write)
    File.open(filename, 'w') do |file|
      file.write(data_to_write)
    end
  end
end
