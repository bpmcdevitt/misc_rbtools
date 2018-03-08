#!/usr/bin/env ruby
# search wikipedia

require 'wikipedia'

args = ARGV

page = Wikipedia.find(args[0])

puts page.title+"\n"
puts page.text+"\n"
