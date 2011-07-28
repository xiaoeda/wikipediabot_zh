require 'rubygems'
require 'sinatra'
require 'tweet.rb'

get '/' do
  Tweet.new.tweet
end
