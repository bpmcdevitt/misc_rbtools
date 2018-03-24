#!/usr/bin/env ruby
# dump csv file contents

require 'csv'
require 'optparse'

# basic commandline parsing
options = {}

parser = OptionParser.new do |parser|
	parser.banner = "Usage: dump_csv.rb [options]" 
	parser.on("-c", "--column int", "The column number to dump.") do |column|
		options[:column] = column
	end
	parser.on("-f", "--filename FILE", "The CSV filename to use.") do |filename|
		options[:filename] = filename
	end
  options[:all] = false
  parser.on("-a", "--all", "Dump all columns") do
    options[:all] = true
  end
end

parser.parse!

col_data = []

CSV.foreach (options[:filename]) {|col| col_data << col[options[:column].to_i]} if (options[:column] and options[:filename])
puts col_data
