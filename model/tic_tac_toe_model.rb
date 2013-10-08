require 'set'

class TicTacToeModel

  def available_squares
    all_squares - taken_squares
  end

  def taken_squares
    @taken_square ||=  []
  end

  def current_players_taken_squares
    if current_player == 'x'
      player_x_taken_squares
    else
      player_o_taken_squares
    end
  end

  def player_x_taken_squares
    @player_x_taken_squares ||= []
  end

  def player_o_taken_squares
    @player_o_taken_squares ||= []
  end

  def winning_sets
    [Set.new([square_0, square_1, square_2]),
    Set.new([square_3, square_4, square_5]),
    Set.new([square_6, square_7, square_8]),
    Set.new([square_0, square_3, square_6]),
    Set.new([square_1, square_4, square_7]),
    Set.new([square_2, square_6, square_8]),
    Set.new([square_0, square_4, square_8]),
    Set.new([square_2, square_4, square_6])]
  end

  def all_squares
    [square_0,
    square_1,
    square_2,
    square_3,
    square_4,
    square_5,
    square_6,
    square_7,
    square_8]
  end

  def square_0
    [[133,133], [301,133], [133,301], [301, 301]]
  end

  def square_1
    [[301,133], [488,133], [301, 301], [488,301]]
  end

  def square_2
    [[488,133], [666,133], [488, 301], [666,301]]
  end

  def square_3
    [[133,301], [301,301], [133, 488], [301,488]]
  end

  def square_4
    [[301,301], [488,301], [301, 488], [488,488]]
  end

  def square_5
    [[488, 301],[666, 301],[488, 488],[666, 488]]
  end

  def square_6
    [[133, 488],[301, 488],[133, 666],[301, 666]]
  end

  def square_7
    [[301, 488],[488, 488], [301, 666], [488, 666]]
  end

  def square_8
    [[488, 488],[666, 488], [488, 666], [666, 666]]
  end

end