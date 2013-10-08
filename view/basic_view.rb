require 'ruby-processing'
require 'set'

class TicTacToe < Processing::App
  attr_accessor :current_player

  def setup
    size 800, 800
    background(0, 0, 0)
    @current_player = 'x'
  end

  def draw
    create_lines
  end

  def create_lines
    stroke 256,256,256
    line 301, 133, 301, 666
    line 488, 133, 488, 666
    line 133, 301, 666, 301
    line 133, 488, 666, 488

    #borders
    line 133, 133, 666, 133
    line 666, 133, 666, 666
    line 133, 666, 666, 666
    line 133, 133, 133, 666
  end

  def mouse_pressed
    all_squares.each do |square|
      if in_range?(mouse_x, mouse_y, square) && available_squares.include?(square)
        draw_move(square)
	      taken_squares << square
        current_players_taken_squares << square
        check_for_win
        change_player
      end
    end
  end

  def in_range?(x_coordinate, y_coordinate, square)
    x_coordinate_range_for(square).include?(x_coordinate)  && y_coordinate_range_for(square).include?(y_coordinate)
  end

  def change_player
    if @current_player == 'x'
      @current_player = 'o'
    else
      @current_player = 'x'
    end
  end

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

  def check_for_win
    print_draw if draw?
    winning_sets.each do |set|
      if set.all? {|square| current_players_taken_squares.include?(square)}
        declare_winner(current_player)
        freeze_board
      end
    end
  end

  def draw?
    available_squares.empty?
  end

  def print_draw
    textSize 16
    fill 256, 256, 254
    text("The game is a draw", 310, 65)
  end

  def declare_winner(player)
    textSize 16
    fill 256, 256, 254
    text("#{player} is the winner!", 310, 65)
  end

  def freeze_board
    @available_squares = []
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

  def draw_move(square)
    render_x(square) if current_player == 'x'
    render_o(square) if current_player == 'o'
  end

  def render_x(square)
    line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
  end

  def render_o(square)
    fill 0, 0, 0, 50
    ellipse (square[0][0]+square[3][0])/2, (square[0][1]+square[3][1])/2, 148, 148
  end

  def x_coordinate_range_for(square)
    (square[0][0]..square[1][0])
  end

  def y_coordinate_range_for(square)
    (square[0][1]..square[3][1])
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

TicTacToe.new(:title => "TicTacToe", :full_screen => false)
