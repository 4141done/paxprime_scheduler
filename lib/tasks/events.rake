namespace :events do

  def parse_panelists panelists
    panelists_for_event = []
    individuals = panelists.split("],")
    individuals.each do |panelist|
      panelist = panelist.split(",")
      affiliation = panelist[1].to_s.gsub(/[\]]/, "").strip
      panelist = panelist[0].split("[")
      name = panelist[0].to_s.strip
      title = panelist[1].to_s.strip

      panelist = Panelist.find_by_name_and_affiliation name, affiliation
      if panelist.blank?
        panelist = Panelist.new
        panelist.name = name
        panelist.affiliation = affiliation
        panelist.title = title
        panelist.save!
        ap "created panelist #{panelist.name}"
      end

      panelists_for_event << panelist
    end

    return panelists_for_event
  end

  def panelists_present? headers
    presence = false
    headers.each do |header|
      presence = header.respond_to?(:text) && header.text == "Panelists:"
      if presence == true
        return presence
      end
    end
    return presence
  end

  def parse_day day, agent, page
    dates_for_days  = { "friday" => "8/31", "saturday" => "9/1", "sunday" => "9/2" }
    current_day = page.search("##{day}")
    ap "now parsing #{day}!"

    time_blocks = current_day.search(".timeBlock")

    time_blocks.each do |block|
      events = block.search("li")

      events.each do |event|
        new_event = Event.new
        new_event.day = day.upcase
        new_event.venue = Venue.find_by_code event.attribute("class").text.split(" ")[1]
        event_link = event.search("a")
        # populat title and url
        new_event.name = event_link.attribute("title").text
        new_event.url = event_link.attribute("href").text

        page = agent.get new_event.url

        full_event = page.search(".full.event")
        description_and_panelists = full_event.search("p")
        headers = full_event.search("h4")

        # populate event description and panelists
        if description_and_panelists.first && description_and_panelists.first.respond_to?(:text)
          new_event.description = description_and_panelists.first.text
        end
        
        panelists = []
        if panelists_present? headers
          if description_and_panelists[1] && description_and_panelists[1].respond_to?(:text)
           panelists = parse_panelists description_and_panelists[1].text
          end
        end
        new_event.panelists = panelists

        #populate times
        times = full_event.search(".date").search("strong").text.split(" - ")
        today = dates_for_days["#{day}"]
        ap "parsing date:"
        ap "#{today} #{times[0]}"
        ap "#{today} #{times[1]}"
        new_event.start_time = DateTime.parse("#{today} #{times[0]}")
        new_event.end_time = DateTime.parse("#{today} #{times[1]}" )
        new_event.save!
        ap "created event:"
        ap new_event
      end
    end
  end
  
  task :populate => :environment do
    url = "http://prime.paxsite.com/schedule"
    agent = Mechanize.new
    page = agent.get url

    #let's populate the locations
    locations = page.search("#locations").search("li")
    locations.each do |location|
      new_venue = Venue.new
      new_venue.code = location.attribute("class").text
      new_venue.name = location.search("a").attribute("title").text
      new_venue.save!
    end

    #get the events

    parse_day "friday", agent, page
    parse_day "saturday", agent, page
    parse_day "sunday", agent, page
  end

end