require 'nokogiri'
require 'open-uri'

def getStats(user)
  page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
  page.css("ul.inline-stats li strong")[3].text.to_i
end

users = [:usmanity, :hcabalic]

users.each { |u| getStats(u) }