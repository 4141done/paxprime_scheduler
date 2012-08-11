require 'nokogiri'
require 'open-uri'

namespace :events do
  
  task :scan => :environment do
    url = "http://prime.paxsite.com/schedule/print"
    doc = Nokogiri::HTML(open(url))
    ap doc
  end

end