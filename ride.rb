require 'sinatra'
require 'nokogiri'
require 'open-uri'

def getStats(user, early)
  page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
  result = [ page.css("h1#athlete-name").text[0..-4], page.css("ul.inline-stats li strong")[3].text.to_f.round(2) - early]
end

users = {"usmanity" => 211, "hcabalic" => 697, "1320215" => 655, "1689644" => 53, "2285604" => 0, "1902953" => 71}

get "/" do
  @riders = {}
  # users.each { |user|
  #   number = getStats(user)
  #   @riders << {:rider => user, :rides => number}
  # }
  users.each { |user, early|
    new = getStats(user, early)
    @riders.merge!({new[0] => new[1]})
    @rides = @riders.sort_by { |k| k[1] }
    @rides.reverse!
  }
  erb :index, :locals => {:riders =>  @rides }
end
