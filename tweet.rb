require 'rubygems'
require 'twitter'
require 'mechanize'
$KCODE = "u"

class Tweet

  def initialize

    Twitter.configure do |config|
      config.consumer_key       = ENV['consumer_key']
      config.consumer_secret    = ENV['consumer_secret']
      config.oauth_token        = ENV['oauth_token']
      config.oauth_token_secret = ENV['oauth_token_secret']
    end
  end

  def tweet
    agent = Mechanize.new
    agent.user_agent_alias = ENV['agent']
    agent.get('http://zh.wikipedia.org/wiki/Special:Randompage')

    title = agent.page.title.split(" - ")
    encodeTitle = URI.encode(title[0])
    url = agent.get_file("http://tinyurl.com/api-create.php?url=http://zh.wikipedia.org/wiki/" + encodeTitle)
    update(title[0] + " " + url)
  end

  private
  def update(tweet)
    return nil unless tweet

    begin
      Twitter.update(tweet)
    rescue => ex
      puts "exception"
      nil # todo
    end
  end

end
