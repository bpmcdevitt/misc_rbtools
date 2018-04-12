#!/usr/bin/env ruby
# CVE class

# the end goal of this is to just be something that i can use to lookup cve quickly from the command line. yes i know that these tools already exist, but what i'm trying to learn more about ruby so why not?

require 'net/http'

class CVE

  def base_uri
    @base_uri ||= 'https://nvd.nist.gov/feeds/'
  end

  def years
    # i know this is long, ill fix it later to generate the numbers or something
    @year ||= %w[
    2002 2003 2004 2005 2006 2007
    2008 2009 2010 2011 2012 2013
    2014 2015 2016 2017 2018]
  end

  def xml_url
    endpoint = 'xml/cve/2.0/'
    url = self.base_uri + endpoint
    uri = URI(url)
  end

  def xml_file(year)
    xml_file = "nvdcve-2.0-#{year}.xml.gz"
  end

end
