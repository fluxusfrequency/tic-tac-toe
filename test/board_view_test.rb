gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../view/board_view.rb'

class BoardViewTest < Minitest::Test

  attr_reader :board

  def setup
    @board = TicTacToe::TicTacToeBoard.new
  end

  def test_it
  end

end