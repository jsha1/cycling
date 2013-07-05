require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'json'
set :public_folder, File.dirname("public")
# set :static, true

def getStats(user, early)
  begin
    page = Nokogiri::HTML(open("http://strava.com/athletes/#{user}"))
    result = [ page.css("h1").text[0..-4], page.css("ul.inline-stats li strong")[3].text.to_f.round(2) - early]
  rescue
    result = ["Unknown user", 0]
  end
end

users = {"usmanity" => 264.0, "hcabalic" => 853.9, "1320215" => 874.5, "1689644" => 253.4, "2285604" => 61.5, "1902953" => 157.9, "2491171" => 0}
#                                                   tiki                dray                jerry              ken                  tim

get "/" do
  @riders = {}
  @total = 0
  # users.each { |user|
  #   number = getStats(user)
  #   @riders << {:rider => user, :rides => number}
  # }
  users.each { |user, early|
    new = getStats(user, early)
    @riders.merge!({new[0] => new[1]})
    @total = @total + new[1]
    @rides = @riders.sort_by { |k| k[0] }
  }
  erb :index, :locals => {:riders =>  @rides, :total => sprintf( "%0.01f", @total) }
end

get '/rides.json' do
  content_type :json
  f = File.open("public/rides.json", "r")
  f.readline()
end

get '/updated' do
  content_type :json
  f = File.open("public/updated.json", "r")
  f.readline()
end
