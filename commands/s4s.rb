if Time.now.to_i -  (public_hash['s4stime']==nil ? 0 : public_hash['s4stime']) > 10
	mutex.synchronize { sends << [message.chat.id, API4.new('s4s').fetch]  }
	public_hash['s4stime'] = Time.now.to_i
else
	mutex.synchronize { sends << [message.chat.id, 'Too Fast, i cant handle it']  }
end
