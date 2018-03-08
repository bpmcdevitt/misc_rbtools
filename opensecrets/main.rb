#!/usr/bin/env ruby
#
require './creds.rb'
require 'net/http'

include ApiCreds
api_key = KEY['api_key']

state_cc = ['AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL',
            'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH',
            'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX'.
            'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY']

target_url = 'http://www.opensecrets.org/api/'


output_type = ['json', 'xml', 'doc']


# method types for opensecrets.org:
# https://www.opensecrets.org/open-data/api-documentation
#
# getLegislators
# memPFDprofile
# candSummary
# candContrib
# candIndustry
# candIndByInd
# candSector
# congCmtIndus
# getOrgs
# orgSummary
# independentExpend
