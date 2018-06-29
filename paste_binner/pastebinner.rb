#!/usr/bin/env ruby
# author: brendan mcdevitt
# a ruby wrapper around all of the methods pastebin provides with its api
require 'rest-client'

class PasteBinner
  # PasteBinner.new(api_dev_key)

  def initialize(api_dev_key)
    @api_dev_key = api_dev_key
    @base_url = 'https://pastebin.com/api'
  end

  # required params for creating pastes, there are also optional params. how best to include?
  # https://pastebin.com/api/api_post.php
  # the api_paste_code must be base64 encoded
  def create_paste(api_paste_code, api_user_key=nil,
                   api_paste_name=nil, api_paste_format=nil,
                   api_paste_private=nil, api_paste_expire_date=nil)
    response = RestClient::Request.new({
                                method: :post,
                                url: @base_url + '/api_post.php',
                                payload: { 'api_dev_key': @api_dev_key,
                                           'api_option': 'paste',
                                           'api_paste_code': api_paste_code }
                                       }).execute do |response, request, result|
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
                                         url: @base_url + '/api_login.php',
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
        fail "Invalid response #{response.to_str} receoved."
      end

      end
  end
end
