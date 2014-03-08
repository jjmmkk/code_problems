class VigenereCipher

	@@default_alphabet = ('a'..'z')

	def initialize (key, alphabet = @@default_alphabet)
		@key = key
		@key_length = key.length

		case alphabet
		when Range
			alphabet = alphabet.to_a.join
		when Array
			alphabet = alphabet.join
		when String
			#
		else
			raise(ArgumentError, 'Alphabet is must be a range, an array or a string')
		end
		@map_char_key = Hash[alphabet.chars.map.with_index.to_a]
		@map_key_char = @map_char_key.invert
		@map_length = @map_char_key.length
	end

	def encrypt (string)
		# See @direction_explained
		return cipher(string, :+)
	end

	def decrypt (string)
		# See @direction_explained
		return cipher(string, :-)
	end

	private

	def cipher (string, direction)
		# Cipher each character
		return string.chars.map.with_index{ |c,i| cipher_char(c, i, direction) }.join
	end

	def cipher_char (character, index, direction)
		# 1.
		# Find the alphabet index of the key
		# character whose turn it is to be used
		key_char = @key[index % @key_length]
		key_char_index = @map_char_key[key_char]

		# 2.
		# Find the alphabet index of the character
		char_index = @map_char_key[character]

		# 3.
		# Thus find the index of the cipher character
		#
		# @direction_explained
		# http://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher#Algebraic_description
		# Adding the indices encrypts
		# Subtracting the key character index encrypts
		#
		# `send` can be explained as object.call( function, parameters … )
		# E.g.
		# 10.send( :-, 5 )
		# => 5
		# 10.send( :+, 5 )
		# => 15
		cipher_char_index = char_index.send(direction, key_char_index) % @map_length
		return @map_key_char[cipher_char_index]
	end

end
