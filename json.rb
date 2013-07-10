require 'nokogiri'
require 'open-uri'
require 'json'

early_user_data = { "usmanity" => [
                                  :miles => 211,
                                  :el => 8821
                                  ],
                    "hcabalic" => [
                                  :miles => 741.4,
                                  :el => 25167
                                  ]
                  }

def get_stats(hash)
  hash.each do |i|
    page = Nokogiri::HTML(open("http://strava.com/athletes/#{i[0]}"))
    puts page.css('h1').text[0..-4]
    puts page.css("ul.inline-stats li strong")[3].text.to_f.round(2)
    # result = [ page.css("h1").text[0..-4], page.css("ul.inline-stats li strong")[3].text.to_f.round(2)]
    # "#{i[0]} has #{i[1][0][:miles]} miles & has climbed #{i[1][0][:el]} feet"
  end
end

puts get_stats(early_user_data)