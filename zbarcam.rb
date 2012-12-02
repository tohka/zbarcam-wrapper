#!/usr/bin/ruby


require 'optparse'

def main
	options = {}

	opt = OptionParser.new
	opt.version = "0.1.0"
	opt.banner = "zbarcam wrapper"

	opt.on('-z PATH', '--zbar=PATH', 'set path to zbarcam') do |v|
		options[:zbarcam] = v
	end
	opt.on('-s PATH', '--sound=PATH',
			'set path to sound played when scanned') do |v|
		options[:sound] = v
	end
	opt.on('-p PATH', '--player=PATH', 'set path to music player') do |v|
		options[:player] = v
	end
	
	begin
		args = opt.parse(ARGV)
	rescue => e
		$stderr.puts "Error: #{e}"
		exit
	end

	options[:zbarcam] = 'zbarcam' unless options[:zbarcam]
	options[:player] = 'mplayer' unless options[:player]

	wrapper(options, args[0])
end

def wrapper(options, output)
	prev = [nil, nil]

	fh = output.nil? ? $stdout : open(output, "a")

	open("| #{options[:zbarcam]}") do |io|
		io.each do |line|
			type, code = line.strip.split(":")
			if filtering(type, code)
				# ignore duplication
				if prev[0] != type || prev[1] != code
					fh.puts "#{type}\t#{code}"
					unless options[:sound].nil?
						`#{options[:player]} #{options[:sound]} >/dev/null 2>&1`
					end
					prev[0] = type
					prev[1] = code
				end
			end
		end
	end

	fh.close unless output.nil?
end

def filtering(type, code)
	# type:
	#   EAN-8, UPC-E, ISBN-10, UPC-A, EAN-13, ISBN-13,
	#   I2/5, CODE-39, CODE-128, PDF417, QR-Code, UNKNOWN
	if type == "EAN-13"
		# Japanese items (45 / 49) or books (97)
		["45", "49", "97"].include?(code[0, 2])
	else
		nil # unsupported
	end
end



main

