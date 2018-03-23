#!/usr/bin/env ruby
# dump csv file contents

require 'csv'
require 'optparse'

# basic commandline parsing
options = {}

parser = OptionParser.new do |parser|
	parser.banner = "Usage: dump_csv.rb [options]" 
	parser.on("-c", "--column INT", "The column number to dump.") do |column|
		options[:column] = column
	end
	parser.on("-f", "--filename NAME", "The CSV filename to use.") do |filename|
		options[:filename] = filename
	end
end

parser.parse!


col_data = []
CSV.foreach(options[:filename]) {|col| col_data << col[options[:column].to_i]}

puts col_data
