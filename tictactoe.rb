require 'ruby-processing'

require './controller/tic_tac_toe_controller.rb'
require './view/board_view.rb'
require './view/moves_view.rb'
require './model/tic_tac_toe_model.rb'

class TicTacToe < Processing::App

  def self.tic_tac_toe_controller
    @@tic_tac_toe_controller ||= TicTacToeController.new
  end

  def self.board_view
    @@board_view ||= BoardView.new
  end

  def self.moves_view
    @@moves_view ||= MovesView.new
  end

  def self.tic_tac_toe_model
    @@tic_tac_toe_model ||= TicTacToeModel.new
  end

end

BoardView.new
