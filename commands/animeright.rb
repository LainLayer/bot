if Time.now.to_i -  (public_hash['twittertime']==nil ? 0 : public_hash['twittertime']) > 10
        mutex.synchronize { sends << [message.chat.id, TwitterAPI.new('#AnimeRight').get_recent]  }
        public_hash['twittertime'] = Time.now.to_i
else
        mutex.synchronize { sends << [message.chat.id, 'Too Fast, i cant handle it']  }
end

