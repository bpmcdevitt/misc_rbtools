#!/usr/bin/env ruby
# author: brendan mcdevitt
# a ruby wrapper around all of the methods pastebin provides with its api
# official docs from pastebin on their api can be found at https://pastebin.com/api
require 'rest-client'

class PasteBinner

  # PasteBinner.new(api_dev_key)
  def initialize(api_dev_key)
    @api_dev_key = api_dev_key
    @base_api_url = 'https://pastebin.com/api'
    @scraping_api_url = 'https://scrape.pastebin.com'
  end

  # this should be a hash of { endpoint_name: '/url_endpoint.php'}
  ENDPOINTS = { :api_login => '/api_login.php',
                :api_post => '/api_post.php',
                :api_raw => '/api_raw.php',
                :api_scraping => '/api_scraping.php',
                :api_scrape_item => '/api_scrape_item.php',
                :api_srape_item_meta => '/api_scrape_item_meta.php' }

  # basic example hash for creating a paste:
  # params = { 'api_dev_key': @api_dev_key, 'api_option': 'paste'. 'api_paste_code': paste_data}

  # required params:
  # api_dev_key - your unique developer api key 
  # api_option - set as paste, this will indicate you want to create a new paste
  # api_paste_code - this is the text that will be written inside of your paste

  # optional params:
  # api_user_key - this parameter is part of the login system, which is explained further down the page
  # api_paste_name - this will be the name / title of your paste
  # api_paste_format - this will be the syntax highlighting value, which is explained in detail further down the page
  # api_paste_private - this makes a paste public, unlisted, or private, public = 0, unlisted = 1, private = 2
  # api_paste_expire_date - this sets the expiration date of your paste, the values are explained further down the page

  def create_paste(params)
    response = RestClient::Request.new(
                                method: :post,
                                url: @base_api_url + ENDPOINTS[:api_post],
                                payload: params ).execute do |response, request, result|
                                case response.code
                                when 400
                                  [ :error, response.to_str ]
                                when 200
                                  [ :success, response.to_str ]
                                else
                                  fail "Invalid reponse #{response.to_str} received."
                                end
    end
  end

  def get_api_user_key(username, password)
    # returns a user session key that can be used as the api_user_key param
    @response ||= RestClient::Request.new({
                                         method: :post,
                                         url: @base_api_url + ENDPOINTS[:api_login],
                                         payload: { 'api_dev_key': @api_dev_key,
                                                    'api_user_name': username,
                                                    'api_user_password': password }
                                          }).execute do |response, request, result|
      case response.code
      when 400
        [ :error, response.to_str ]
      when 200
        [ :success, response.to_str]
      else
        fail "Invalid response #{response.to_str} received."
      end
    end
  end
end

######################## TESTING ####################################################
#####################################################################################
#
# CREATE PASTE
#
# setup our api key
api_dev_key = ENV['pastebin_api_key']

# setup our object and grab a session key
pb =  PasteBinner.new(api_dev_key)
api_user_key = pb.get_api_user_key(ENV['pastebin_username'], ENV['pastebin_password'])

# here is some paste content
paste_data = 'this is a test paste two two two.'
# prepare our paste params
params = { "api_dev_key": api_dev_key, "api_option": "paste", "api_paste_code": paste_data }

puts pb.create_paste(params)

