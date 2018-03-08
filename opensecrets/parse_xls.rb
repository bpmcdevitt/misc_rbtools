#!/usr/bin/env ruby
# testing parsing xls files
#
require 'roo-xls'

args = ARGV
first_name = args[0]
last_name = args[1]

# load the spreedsheet
xls = Roo::Spreadsheet.open('./data/CRP_IDs.xls', extension: :xls)

# summary info of the spreedsheet
xls.info

# loop through the given spreadsheet columns, and create a hash
# create a hash(dict) of cid and crpname of everyone on a spreadsheet
#
xls.sheet(0).each(cid: 'CID', crpname: 'CRPName') do |hash|
  if hash.has_value?("#{last_name}, #{first_name}")
    puts "Found: #{first_name} #{last_name}" 
    puts "CID: #{hash.values[0]}"
  end
end
