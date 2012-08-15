class User < ActiveRecord::Base
  attr_accessible :identifier

  def self.generate_identifier
    agent = Mechanize.new
    page = agent.get "http://seattle.craigslist.org/zip/"
    link1 = page.links[rand(page.links.length)].text.split(" ")
    link2 = page.links[rand(page.links.length)].text.split(" ")
    possible_identifier = link1[rand(link1.length)].to_s + "_" + link2[rand(link2.length)]

    if possible_identifier == nil
      possible_identifier = (link1[rand(link1.length)].to_s + "_" + link2[rand(link2.length)])
    end

    return possible_identifier.scan(/\w+/).join("_").downcase
  end
end