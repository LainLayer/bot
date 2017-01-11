public_hash['remember'] = Hash.new if public_hash['remember'] == nil
if args.length < 1
	mutex.synchronize { sends << [message.chat.id, 'missing argument'] }
else
	public_hash['remember'][message.from.username] = args.join(' ')
	mutex.synchronize { sends << [message.chat.id, 'remembered!'] }
end

