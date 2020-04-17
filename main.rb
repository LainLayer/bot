File.read('gems.txt').split("\n").each { |gem| require gem  }#comment
Dir['src/*.rb'].each { |file| require_relative file }
DEBUG = true
TALK = true
mutex = Mutex.new
ph = Mutex.new
commands = Hash.new
Dir['commands/*'].each { |filename| commands[filename.split('/').last.split('.').first] = File.read(filename) }
if !File.exists?('data/public_hash.json') or File.read('data/public_hash.json').length < 2
	public_hash = Hash.new
else
	public_hash = JSON.parse(File.read('data/public_hash.json'))
end
require 'telegram/bot'

sends = []

def to_command(text)
	a = text.gsub("\n", ' ').split(' ')
	command = a[0][1..-1]
	a.shift
	return command, a
end

Telegram::Bot::Client.run(File.read('token').strip, timeout: 1, logger: CustLog.new) do |bot|
	Thread.new do
		loop do
			a = gets.strip
			next if a[-1] == '%'
			mutex.synchronize { sends << ['<chat handle>', a] }
		end
	end if TALK
	Thread.new do
		loop do
			a = nil
			mutex.synchronize do
				a = sends.shift
			end if sends.length != 0

			next if a == nil
			bot.api.send_message(chat_id: a[0], text: a[1])
			sleep 0.5
		end
	end
	puts 'BOT ON'
	bot.listen do |message|
		begin
			command, args = to_command(message.text)
			cmd = commands[command.gsub('@RecursiveBot','').downcase]
			if cmd != nil
				begin
					ph.synchronize { eval(cmd) }
				rescue => e
					mutex.synchronize { sends << ['154857742', e]  }
				end
				File.open('data/public_hash.json', 'w').write(public_hash.to_json)
			end
		rescue => e
			mutex.synchronize { sends << ['154857742', e] }
		end if (message.text[0] == '/' and message.text.length > 3) if message.text != nil if message != nil
	end

end rescue Telegram::Bot::Client.run(File.read('token').strip, timeout: 1) { |bot| bot.api.send_message(chat_id: '154857742', text: 'Bot is dead')  }

