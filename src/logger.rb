class CustLog
	INFO = 'info'.cyan
	DEBUG = 'debug'.green
	WARN = 'warning'.yellow
	FATAL = 'fatal'.red
	EROR = 'error'.magenta
	UNKO = 'unknown'.blue

	def initialize
		@buffer = []
	end

	def info(text)
		add("[#{INFO}]: #{text}")
	end

	def debug(text)
		add("[#{DEBUG}]: #{text}")
	end

	def warn(text)
		add("[#{WARN}]: #{text}")
	end

	def fatal(text)
		add("[#{FATAL}]: #{text}")
	end

	def error(text)
		add("[#{EROR}]: #{text}")
	end

	def unknown(text)
		add("[#{UNKO}]: #{text}")
	end

	def add(text)
		dump() if @buffer.length >= 5
		puts text
		@buffer << text
	end

	def dump
		File.open('data/log.txt', 'a').puts(@buffer.join("\n"))
		@buffer = []
	end
end
