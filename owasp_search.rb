#!/usr/bin/env ruby
# owasp search
# https://github.com/kenpratt/wikipedia-client
# reusing this gem with owasp url instead

require 'wikipedia'


Wikipedia.configure do
    protocol 'https'
    domain 'www.owasp.org'
    path '/api.php'
    user_agent(
      'owasp-client/0.1 (https://github.com/booboy/owasp-client)'
    )
  end


search_term = ARGV[0]

page = Wikipedia.find( search_term )

puts page.title
puts '-----------------------------------------------------------------'
puts page.fullurl
puts '-----------------------------------------------------------------'
puts page.content
puts '-----------------------------------------------------------------'
puts page.links
puts '-----------------------------------------------------------------'
