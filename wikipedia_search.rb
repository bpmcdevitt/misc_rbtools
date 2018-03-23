#!/usr/bin/env ruby
# search wikipedia

require 'wikipedia'

search_words = ARGV[0]

page = Wikipedia.find(search_words)

puts page.title+"\n"
puts page.text+"\n"
