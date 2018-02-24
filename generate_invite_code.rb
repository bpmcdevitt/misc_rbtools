#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'base64'

# send the POST request to generate the code
uri = URI('https://www.hackthebox.eu/api/invite/generate')
res = Net::HTTP.post_form(uri, 'q' => 'ruby', 'max' => '50')

# parse through the http response from our POST request and extract just the
# base64 encode data

json = JSON.parse res.body

# base64 decode it
invite_code = Base64.decode64(json['data']['code'])
puts invite_code
