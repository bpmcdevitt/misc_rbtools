#!/usr/bin/env ruby

require 'twitter'
load './secret'

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.access_token = ACCESS_TOKEN
  config.access_token_secret = ACCESS_TOKEN_SECRET
end

def get_followers(client, username)
  followers = client.followers(username)
  begin
    followers.to_a
  rescue Twitter::Error::TooManyRequests => error
    # NOTE: Your process could go to sleep for up to 15 min but if you retry
    # any sooner, it will almost certaintly fail with the same exception.
    sleep error.rate_limit.reset_in + 1
    retry
  end
end

puts get_followers(client, 'bpmcdevitt')
