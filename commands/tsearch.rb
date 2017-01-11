if Time.now.to_i -  (public_hash['tsearchtime']==nil ? 0 : public_hash['tsearchtime']) > 10
	if args.length > 0
        	mutex.synchronize { sends << [message.chat.id, TwitterAPI.new(args.join(' ')).get_recent]  }
	        public_hash['tsearchtime'] = Time.now.to_i
	else
		mutex.synchronize { sends << [message.chat.id, 'search what?']}
	end
else
        mutex.synchronize { sends << [message.chat.id, 'Too Fast, i cant handle it']  }
end

