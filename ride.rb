require 'sinatra'
require 'nokogiri'
require 'open-uri'

def getStats(user, early)
  page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
  result = [ page.css("h1#athlete-name").text, page.css("ul.inline-stats li strong")[3].text.to_i - early]
end

users = {"usmanity" => 211, "hcabalic" => 697, "1320215" => 655, "1689644" => 53}

get "/" do
  @riders = {}
  # users.each { |user|
  #   number = getStats(user)
  #   @riders << {:rider => user, :rides => number}
  # }
  users.each { |user, early|
    new = getStats(user, early)
    @riders.merge!({new[0] => new[1]})
  }
  erb :index, :locals => {:riders =>  @riders }
end
