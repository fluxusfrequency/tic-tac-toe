require 'ruby-processing'
require 'set'

class BoardView

  attr_reader :window_width, :window_height, :model,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize
    model = TicTacToeModel.new
    background(0, 0, 0)
    set_window_size(800,800)
    size @window_width, @window_height
  end

  def draw
    create_board
  end

  def create_board
    stroke 256,256,256
    create_grid
    create_borders
  end

  def create_grid
    line v2[0], v2[1], v14[0], v14[1]
    line v3[0], v3[1], v15[0], v15[1]
    line v5[0], v5[1], v8[0], v8[1]
    line v9[0], v9[1], v12[0], v12[1]
  end

  def create_borders
    line v1[0], v1[1], v4[0], v4[1]
    line v4[0], v4[1], v16[0], v16[1]
    line v13[0], v13[1], v16[0], v16[1]
    line v1[0], v1[1], v13[0], v13[1]
  end


  def set_window_size(width=800, height=800)
    @window_width = width
    @window_height = height
  end
end

class MoveView < Processing::App

#  attr_reader :window_width, :window_height, :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8, :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def setup
    #array of Squares calling from the controller
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

  def render_x(square)
    line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
  end

  def render_o(square)
    fill 0, 0, 0, 50
    ellipse (square[0][0]+square[3][0])/2, (square[0][1]+square[3][1])/2, 148, 148
  end

end

class TicTacToeModel

  attr_accessor :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
  :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize
    define_vertices
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

  def define_vertices
    @v1 = [window_width*1/5, window_height*1/5]
    @v2 = [window_width*2/5, window_height*1/5]
    @v3 = [window_width*3/5, window_height*1/5]
    @v4 = [window_width*4/5, window_height*1/5]
    @v5 = [window_width*1/5, window_height*2/5]
    @v6 = [window_width*2/5, window_height*2/5]
    @v7 = [window_width*3/5, window_height*2/5]
    @v8 = [window_width*4/5, window_height*2/5]
    @v9 = [window_width*1/5, window_height*3/5]
    @v10 = [window_width*2/5, window_height*3/5]
    @v11 = [window_width*3/5, window_height*3/5]
    @v12 = [window_width*4/5, window_height*3/5]
    @v13 = [window_width*1/5, window_height*4/5]
    @v14 = [window_width*2/5, window_height*4/5]
    @v15 = [window_width*3/5, window_height*4/5]
    @v16 = [window_width*4/5, window_height*4/5]
  end

  #conver to vertices
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

class TicTacToe < Processing::App

  attr_accessor :current_player, :board

  def setup
    @board = Board.new
  end

  def draw
    board.draw
  end

  def initialize(squares)
    #pass square in logic
    @current_player = 'x'
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

  def x_coordinate_range_for(square)
    (square[0][0]..square[1][0])
  end

  def y_coordinate_range_for(square)
    (square[0][1]..square[3][1])
  end

  def freeze_board
    @available_squares = []
  end

  def draw?
    available_squares.empty?
  end
end
