class Build_deck
	def initialize
		@cards = []
		values = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
		suits = ['C', 'D', 'H', 'S']
		suits.each do |suit|
			values.each { |value|
				@cards << value + suit
			}
		end
		@cards
	end
	attr_reader :cards
end
