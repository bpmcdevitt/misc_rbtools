#!/usr/bin/env ruby
# CVE class

# using this code as example to start:
# https://github.com/fidius/cvedb/blob/master/lib/tasks/parse_cves.rake

require 'net/http'

class CVE

  def base_uri
    @base_uri ||= 'https://nvd.nist.gov/feeds/'
  end

  def cve_years
    # i know this is long, ill fix it later to generate the numbers or something
    @cve_years ||= %w[
    2002 2003 2004 2005 2006 2007
    2008 2009 2010 2011 2012 2013
    2014 2015 2016 2017 2018]
  end

    def xml_feed
      endpoint = 'cve/2.0/'
      uri = URI(base_uri)
    end
end
