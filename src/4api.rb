class API4
	def initialize(board)
		@board = board
	end

	def fetch
		arr = Set.new
		agent = Mechanize.new
		page = "http://a.4cdn.org/#{@board}/#{rand(1..10)}.json"
		data = agent.get(page).body
		threads = JSON.parse(data)['threads']
		threads.each do |thread|
			thread["posts"].each do |post|
				arr << "https://i.4cdn.org/#{@board}/" +  post["tim"].to_s + post["ext"] if post["filename"] != nil && post["ext"] != nil
			end
		end
		return arr.to_a.sample
	end
end
