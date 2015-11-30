require 'nokogiri'


class TwitterScrapper

  def initialize(url)
   	@url = Nokogiri::HTML(File.open(url))
  end
  
  def extract_username
    user = @url.search(".ProfileHeaderCard-name > a")
    user.first.inner_text
  end

  def extract_tweets
    tweets = @url.search(".ProfileNav-value") 
    tweets.first.inner_text
  end

  def extract_followings
    followings = @url.search(".ProfileNav-value")
    followings[1].inner_text  
  end

  def extract_followers
    followers = @url.search(".ProfileNav-value")
    followers[2].inner_text  
  end

  def extract_likes
    likes = @url.search(".ProfileNav-value")
    likes[3].inner_text    
  end

  def show_date_and_tweet
    result = []
    dates = []
    tweets = [] 
    tweets_stream = @url.search("#stream-items-id").xpath("//li")
    tweets_stream.each do |tweet_content|
       dates << tweet_content.search(".js-short-timestamp").inner_text
       tweets << tweet_content.search(".tweet-text").inner_text
    end
    result << dates.reject!(&:empty?)
    result << tweets.reject!(&:empty?)
    result
  
  end

  def interfaz
	puts "Username: #{extract_username}"
  puts ""
	puts "-----------------------------------------------------------------------------------------"
  puts ""
  puts "Stats:"
	puts "Tweets: #{extract_tweets}         followings: #{extract_followings}" 
  puts "followers: #{extract_followers}     likes: #{extract_likes}"
  puts ""
  puts "-----------------------------------------------------------------------------------------"
  puts ""
  puts "Tweets:"
  show_date_and_tweet[0].each_with_index do |date, index|
    puts date
    puts show_date_and_tweet[1][index]
  end
  puts ""
  end
end

display = TwitterScrapper.new('twitter_account.html')
display.interfaz
display.extract_username
display.extract_tweets
display.extract_followings
display.extract_followers
display.extract_likes
display.show_date_and_tweet
# values = {tweets: stats[0].inner_text, followings: stats[1].inner_text, followers: stats[2].inner_text, likes: stats[3].inner_text}
# stats = stats[0].inner_text, stats[1].inner_text, stats[2].inner_text, stats[3].inner_text
   