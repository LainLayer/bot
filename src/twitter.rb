

class TwitterAPI

	def initialize(hashtag)
		data = JSON.parse(File.read('data/twitter.json'))
		@client = Twitter::REST::Client.new do |c|
		        c.consumer_key = data['consumer_key']
	        	c.consumer_secret = data['consumer_secret']
		        c.access_token = data['access_token']
		        c.access_token_secret = data['access_secret']
		end

		@hashtag = hashtag
	end

	def get_recent
		tweet = @client.search(@hashtag, result_type: 'recent').take(10).sample
		return "#{tweet.user.screen_name}: #{tweet.text}"
	rescue
		return "Not found"
	end
end
