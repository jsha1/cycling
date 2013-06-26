require 'nokogiri'
require 'open-uri'
require 'json'

def getStats(user, early)
  page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
  result = [ page.css("h1#athlete-name").text[0..-4], page.css("ul.inline-stats li strong")[3].text.to_f.round(2) - early]
end

def fetch_rides
  @riders = {}
  @total = 0
  rides_json = File.open("public/rides.json", "w+")
  users = {"usmanity" => 211,
           "hcabalic" => 697,
           "1320215" => 655,
           "1689644" => 53,
           "2285604" => 0,
           "1902953" => 71
          }
  users.each { |user, early|
    new = getStats(user, early)
    @riders.merge!({new[0] => new[1].to_f.round(2)})
    @total = @total + new[1]
    @rides = @riders.sort_by { |k| k[0] }
  }
  rides_json.write(@riders.to_json)
  # erb :index, :locals => {:riders =>  @rides, :total => sprintf( "%0.01f", @total) }
end

def updated_time
  update_json = File.new("public/updated.json", "w+")
  update_json.write(Time.now().to_json)
  puts Time.now()
end

fetch_rides()
updated_time()