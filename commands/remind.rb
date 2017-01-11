public_hash['remember'] = Hash.new  if public_hash['remember'] == nil
if public_hash['remember'][message.from.username] != nil
	mutex.synchronize{ sends << [message.chat.id, public_hash['remember'][message.from.username]] }
else
	mutex.synchronize{ sends << [message.chat.id, 'nothing to remind'] }
end
