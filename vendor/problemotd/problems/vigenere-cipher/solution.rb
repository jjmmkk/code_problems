#!/usr/bin/ruby

#
# Usage:
# ruby solution.rb
#
# Prompt for cipher key and message:
# ruby solution.rb -p
#


require './vigenere_cipher.rb'


# Prompt for input values?
if ARGV.first === '-p'
	def prompt (message)
		STDOUT.puts(message)
		while true
			STDOUT.print('> ')
			input = STDIN.gets.chomp
			if input =~ /^[a-z]+$/
				break
			end
		end
		return input
	end

	alphabet = ('a'..'z')

	puts
	plaintext = prompt('Please enter the string to encrypt [a-z]')
	key = prompt('Please enter the key string [a-z]')
	puts

# Use the problem text values
else
	alphabet = ('A'..'Z')
	plaintext = 'TODAYISMYBIRTHDAY'
	key = 'REDDIT'
end

puts "Using key '#{key}' with message '#{plaintext}'"

puts '------'

vigener = VigenereCipher.new(key, alphabet)
encrypted = vigener.encrypt(plaintext)
puts 'Encrypted:'
puts encrypted

puts '------'

puts 'Decrypted:'
puts vigener.decrypt( encrypted )
