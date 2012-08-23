class User < ActiveRecord::Base
  attr_accessible :identifier
  has_one :schedule
  has_many :schedule_entries,  :through => :schedule
  has_many :shared_schedules
  
  def self.generate_identifier
    name_material = ["http://seattle.craigslist.org/zip/", "http://seattle.craigslist.org/jjj/", "http://seattle.craigslist.org/ccc/"]
    agent = Mechanize.new
    page = agent.get name_material[rand(2)]
    link1 = page.links[rand(page.links.length)].text.split(" ")
    link2 = page.links[rand(page.links.length)].text.split(" ")
    possible_identifier = link1[rand(link1.length)].to_s + "_" + link2[rand(link2.length)]

    if possible_identifier == nil
      possible_identifier = (link1[rand(link1.length)].to_s + "_" + link2[rand(link2.length)])
    end

    return possible_identifier.scan(/\w+/).join("_").downcase
  end
end