require 'nokogiri'
require 'open-uri'

class Ride
  def self.getStats(user, early)
    page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
    result = [ page.css("h1#athlete-name").text, early - page.css("ul.inline-stats li strong")[3].text.to_i]
  end
end

users = {"usmanity" => 211, "hcabalic" => 697, "1320215" => 655, "1689644" => 53}

r = Ride.getStats("usmanity", 500)

Ride.addToFile(r)