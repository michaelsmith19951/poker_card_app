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
class Card_values	
	def initialize
		deck = Build_deck.new
		counter = 2
		@value_hash = Hash.new
		deck.cards.each_with_index do |card, value|
			value = counter
			@value_hash[card] = value
			if counter < 14
				counter += 1
			else
				counter = 2
			end
		end
		@value_hash		
	end
	attr_reader :value_hash
end
class Deal_hands	
	def initialize
		cards = Build_deck.new
		cards = cards.cards
		black = ['Black:']
		white = ['White:']
		@hands = []
		shuffle = cards.shuffle!
		counter = 0 
		shuffle.each_with_index do |deal, index|
			unless counter < 3	|| counter > 12
				if index.even? == false
					black << deal
				else
					white << deal
				end
			end
			counter += 1	
		end
		@hands << black 
		@hands << white 				
	end
	attr_accessor :hands
end
class Group 
	def initialize
		card_values = Card_values.new
		value_hash = card_values.value_hash
		stuff = Deal_hands.new
		@check_hands = stuff.hands
		# @check_hands = [["Black:", "AD", "JS", "KH", "QC", "9D"], ["White:", "AD", "JC", "KH", "QC", "8S"]]
		@check_hands[2] = []
		@check_hands[3] = []
		count = 2
		@check_hands[0..1].each do |hand|
			hand[1..5].each { |card| value_hash.each { |key, value| 
				if card == key
					@check_hands[count] << value
				end
				}
			}
			count += 1	 
		end
		@check_hands[2] = @check_hands[2].sort
		@check_hands[3] = @check_hands[3].sort
		@check_hands
		@check_hands[4] = []
		@check_hands[5] = []
		count = 4		
		@check_hands[2..3].each do |hand|
			hand.each do |card|
				if card == 14
		    		@check_hands[count] << "Ace"
		    	elsif card == 13
					@check_hands[count] << "King"
		    	elsif card == 12
		    		@check_hands[count] << "Queen"
		    	elsif card == 11
		    		@check_hands[count] << "Jack"
		    	else
		    		@check_hands[count] << card	
		    	end
		    end	
		    count += 1
		end    
		@check_hands
	end
	attr_accessor :check_hands
end
class Checking_hands
  	def initialize
  		@player_hands = Group.new
   		@hand_group = @player_hands.check_hands
 	  	@hand_group[0][6] = "#{@hand_group[4][4]} High"
 	  	@hand_group[7] = [0, @hand_group[2][4], @hand_group[2][3], @hand_group[2][2], @hand_group[2][1], @hand_group[2][0]]
 	  	@hand_group[1][6] = "#{@hand_group[5][4]} High"
 	  	@hand_group[8] = [0, @hand_group[3][4], @hand_group[3][3], @hand_group[3][2], @hand_group[3][1], @hand_group[3][0]]
 	  	checking_pair << @hand_group
 	  	checking_two_pair << @hand_group
 	  	checking_three << @hand_group
 	  	checking_straight << @hand_group
 	  	checking_flush << @hand_group
 	  	checking_full_house << @hand_group
 	  	checking_four << @hand_group
 	end
 	def checking_pair
 		checking_pair = @hand_group
		counter = 0
		checking_pair[4..5].each do |hands|
			if hands.uniq.length == 4
				if hands[4] == hands[3]
					checking_pair[counter][6] = "Pair of #{hands[4]}s"
					checking_pair[counter + 7] = [10, checking_pair[counter + 2][4], checking_pair[counter + 2][3], checking_pair[counter + 2][2], checking_pair[counter + 2][1], checking_pair[counter + 2][0]]				
				elsif hands[3] == hands[2]
					checking_pair[counter][6] = "Pair of #{hands[3]}s"
					checking_pair[counter + 7] = [10, checking_pair[counter + 2][3], checking_pair[counter + 2][2], checking_pair[counter + 2][4], checking_pair[counter + 2][1], checking_pair[counter + 2][0]]				
				elsif hands[2] == hands[1]
					checking_pair[counter][6] = "Pair of #{hands[2]}s"
					checking_pair[counter + 7] = [10, checking_pair[counter + 2][2], checking_pair[counter + 2][1], checking_pair[counter + 2][4], checking_pair[counter + 2][3], checking_pair[counter + 2][0]]				
				elsif hands[1] == hands[0]
					checking_pair[counter][6] = "Pair of #{hands[1]}s"
					checking_pair[counter + 7] = [10, checking_pair[counter + 2][1], checking_pair[counter + 2][0], checking_pair[counter + 2][4], checking_pair[counter + 2][3], checking_pair[counter + 2][2]]				
				end
			end
			counter += 1
		end
		checking_pair 
	end
	def checking_two_pair
		checking_two_pair = @hand_group
		counter = 0
		checking_two_pair[4..5].each do |hands|
			if hands.uniq.length == 3
				if hands[4] == hands[3] && hands[2] == hands[1]
					checking_two_pair[counter][6] = "Two Pair #{hands[4]}s and #{hands[2]}s"
					checking_two_pair[counter + 7] = [20, checking_two_pair[counter + 2][4], checking_two_pair[counter + 2][3], checking_two_pair[counter + 2][2], checking_two_pair[counter + 2][1], checking_two_pair[counter + 2][0]]
				elsif hands[0] == hands[1] && hands[2] == hands[3]
					checking_two_pair[counter][6] = "Two Pair #{hands[3]}s and #{hands[0]}s"	 
					checking_two_pair[counter + 7] = [20, checking_two_pair[counter + 2][3], checking_two_pair[counter + 2][2], checking_two_pair[counter + 2][1], checking_two_pair[counter + 2][0], checking_two_pair[counter + 2][4]]
				elsif hands[0] == hands[1] && hands[4] == hands[3]
					checking_two_pair[counter][6] = "Two Pair #{hands[4]}s and #{hands[0]}s"
					checking_two_pair[counter + 7] = [20, checking_two_pair[counter + 2][4], checking_two_pair[counter + 2][3], checking_two_pair[counter + 2][1], checking_two_pair[counter + 2][0], checking_two_pair[counter + 2][2]]
				end
			end	
			counter += 1
		end
		checking_two_pair								
	end
	def checking_three
		checking_three = @hand_group
		counter = 0
		checking_three[4..5].each do |hands|
			if hands.uniq.length == 3
				if hands[4] == hands[2]
					checking_three[counter][6] = "Three of a Kind #{hands[4]}s"
					checking_three[counter + 7] = [30, checking_three[counter + 2][4], checking_three[counter + 2][3], checking_three[counter + 2][2], checking_three[counter + 2][1], checking_three[counter + 2][0]]
				elsif hands[0] == hands[2]
					checking_three[counter][6] = "Three of a Kind #{hands[0]}s"
					checking_three[counter + 7] = [30, checking_three[counter + 2][0], checking_three[counter + 2][1], checking_three[counter + 2][2], checking_three[counter + 2][4], checking_three[counter + 2][3]]
				elsif hands[1] == hands[3]
					checking_three[counter][6] = "Three of a Kind #{hands[1]}s"
					checking_three[counter + 7] = [30, checking_three[counter + 2][1], checking_three[counter + 2][2], checking_three[counter + 2][3], checking_three[counter + 2][4], checking_three[counter + 2][0]]
				end
			end
			counter += 1
		end
		checking_three
	end
	def checking_straight
		checking_straight = @hand_group
		counter = 0
		checking_straight[2..3].each do |hand|
			check1 = hand[4] - hand[3]
			check2 = hand[3] - hand[2]
			check3 = hand[2] - hand[1]
			check4 = hand[1] - hand[0]
			if check1 == 1 && check2 == 1 && check3 == 1 && check4 == 1
				checking_straight[counter][6] = "#{checking_straight[counter + 4][4]} High Straight"
				checking_straight[counter + 7] = [40, checking_straight[counter + 2][4], checking_straight[counter + 2][3], checking_straight[counter + 2][2], checking_straight[counter + 2][1], checking_straight[counter + 2][0]]
			end
			counter += 1
		end		
	end
	def checking_flush
		checking_flush = @hand_group	
		suit_check = []
		compare_suits = []
			checking_flush[0..1].each do |hand|
				hand[1..5].each do |suits|			
					suits = suits.split('')
					suit_check << suits[1]			 
				end
			end
		counter = 0
		compare_suits << suit_check[0..4]		
		compare_suits << suit_check[5..9] 	
		compare_suits.each do |hand|
			if hand.uniq.length == 1 && checking_flush[counter][6].include?("High Straight")
				if checking_flush[4 + counter][4] == "Ace"
					checking_flush[counter][6] = "Royal Straight Flush"
					checking_flush[counter + 7] = [90, checking_flush[counter + 2][4], checking_flush[counter + 2][3], checking_flush[counter + 2][2], checking_flush[counter + 2][1], checking_flush[counter + 2][0]]
				else	
					checking_flush[counter][6] = "#{checking_flush[counter + 4][4]} High Straight Flush"
				checking_flush[counter + 7] = [80, checking_flush[counter + 2][4], checking_flush[counter + 2][3], checking_flush[counter + 2][2], checking_flush[counter + 2][1], checking_flush[counter + 2][0]]
				end	
			elsif hand.uniq.length == 1 && checking_flush[counter][6].include?("High Straight") == false
				checking_flush[counter][6] = "#{checking_flush[counter + 4][4]} High Flush"	
				checking_flush[counter + 7] = [50, checking_flush[counter + 2][4], checking_flush[counter + 2][3], checking_flush[counter + 2][2], checking_flush[counter + 2][1], checking_flush[counter + 2][0]]
			end
			counter += 1
		end
		checking_flush
	end		
	def checking_full_house
		checking_full_house = @hand_group
		count = 0
		checking_full_house[4..5].each do |x|
			if x.uniq.length == 2
				if x[4] == x[2] || x[0] == x[2]
					unless x[4] == x[1] || x[0] == x[3]
					    if x[4] == x[2]								
							checking_full_house[count][6] = "Full House #{x[4]}s and #{x[0]}s"
							checking_full_house[count + 7] = [60, checking_full_house[count + 2][4], checking_full_house[count + 2][3], checking_full_house[count + 2][2], checking_full_house[count + 2][1], checking_full_house[count + 2][0]]
						else
							checking_full_house[count][6] = "Full House #{x[0]}s and #{x[4]}s"
							checking_full_house[count + 7] = [60, checking_full_house[count + 2][0], checking_full_house[count + 2][1], checking_full_house[count + 2][2], checking_full_house[count + 2][3], checking_full_house[count + 2][4]]
						end							
					end	
				end	
			end
			count += 1
		end
		checking_full_house
	end
	def checking_four
		checking_four = @hand_group
		counter = 0
		checking_four[4..5].each do |x|
			if x[4] == x[3] && x[3] == x[2] && x[2] == x[1]
				checking_four[counter][6] = "Four of a Kind #{x[4]}s"
				checking_four[counter + 7] = [70, checking_four[counter + 2][4], checking_four[counter + 2][3], checking_four[counter + 2][2], checking_four[counter + 2][1], checking_four[counter + 2][0]]
			elsif x[0] == x[1] && x[1] == x[2] && x[2] == x[3]	
				checking_four[counter][6] = "Four of a Kind #{x[0]}s"
				checking_four[counter + 7] = [70, checking_four[counter + 2][0], checking_four[counter + 2][1], checking_four[counter + 2][2], checking_four[counter + 2][3], checking_four[counter + 2][4]]
			end
			counter += 1		
		end
		checking_four	
	end
	attr_accessor :hand_group
end
class Pick_winner
	def initialize
		final = Checking_hands.new
		@final_hands = final.hand_group
		check_winner << @final_hands
	end
	def check_winner
	 	check_winner = @final_hands
	  	black = check_winner[0][6]
	  	white = check_winner[1][6]
	  	black_high = check_winner[7]
	  	white_high = check_winner[8]
	 	counter = 0
	  	result = ["Tie"]
	  	black_high.each do |score|
	  		if score > white_high[counter]
	  			result = ["Black wins with #{black}"]
	  			break
	  		elsif score < white_high[counter]
	  			result = ["White wins with #{white}"]
	  			break
	 		end		 	
	  		counter += 1
	  	end
		check_winner[6] = result
		check_winner	
 	end					
	attr_accessor :final_hands	
end
class The_game
	def initialize
		arrays = Pick_winner.new
		array = arrays.final_hands
		@everything = []
		@everything << array[0]
		@everything << array[1]
		@everything << array[6]
		@everything
	end
	attr_reader :everything	 
end