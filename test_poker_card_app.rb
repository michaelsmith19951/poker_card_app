require 'minitest/autorun'
require_relative 'poker_functions.rb'
class Poker_test < Minitest::Test

	def test_deck_returns_array
		assert_equal(Array, deck().class)
	end