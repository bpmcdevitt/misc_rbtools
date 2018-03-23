#!/usr/bin/env ruby
# search wikipedia

require 'wikipedia'

search_words = ARGV[0]

page = Wikipedia.find(search_words)

puts page.title
puts '--------------------------------------------------------------'
puts page.fullurl
puts '--------------------------------------------------------------'
puts page.text
