require 'ruby-processing'
require 'set'

class BoardView

  attr_reader :window_width, :window_height, :app, :model,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize(app, model)
    @app ||= app
    @model ||= model
    app.background(0, 0, 0)
    app.size model.window_width, model.window_height
  end

  def create_board
    app.stroke 256,256,256
    create_grid
    create_borders
  end

  def create_grid
    app.line model.v2[0], model.v2[1], model.v14[0], model.v14[1]
    app.line model.v3[0], model.v3[1], model.v15[0], model.v15[1]
    app.line model.v5[0], model.v5[1], model.v8[0], model.v8[1]
    app.line model.v9[0], model.v9[1], model.v12[0], model.v12[1]
  end

  def create_borders
    app.line model.v1[0], model.v1[1], model.v4[0], model.v4[1]
    app.line model.v4[0], model.v4[1], model.v16[0], model.v16[1]
    app.line model.v13[0], model.v13[1], model.v16[0], model.v16[1]
    app.line model.v1[0], model.v1[1], model.v13[0], model.v13[1]
  end

end

class MoveView

  attr_reader :model, :squares, :app

  def initialize(app, model)
    @model = model
    @squares = model.all_squares
    @app ||= app
  end

  def draw_move(square)
    render_x(square) if app.current_player == 'x'
    render_o(square) if app.current_player == 'o'
  end

  def print_draw
    app.textSize 16
    app.fill 256, 256, 254
    app.text("The game is a draw", model.window_width*2/5, model.window_height*1/10)
  end

  def declare_winner(player)
    app.textSize 16
    app.fill 256, 256, 254
    app.text("#{player} is the winner!", model.window_width*2/5, model.window_height*1/10)
  end

  def render_x(square)
    app.line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    app.line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
  end

  def render_o(square)
    app.fill 0, 0, 0, 50
    app.ellipse((square[0][0]+square[3][0])/2, (square[0][1]+square[3][1])/2, model.window_width*1/5, model.window_height*1/5)
  end
end

class TicTacToeModel

  attr_accessor :window_width, :window_height, :app,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize(app)
    @app = app
    set_window_size
    define_vertices
  end

  def available_squares
    all_squares - taken_squares
  end

  def taken_squares
    @taken_squares ||=  []
  end

  def empty_available_squares
    @taken_squares = all_squares
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
    Set.new([square_2, square_5, square_8]),
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

  def set_window_size(width=800, height=800)
    @window_width = width
    @window_height = height
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

  def square_0
    [v1, v2, v5, v6]
  end

  def square_1
    [v2, v3, v6, v7]
  end

  def square_2
    [v3, v4, v7, v8]
  end

  def square_3
    [v5, v6, v9, v10]
  end

  def square_4
    [v6, v7, v10, v11]
  end

  def square_5
    [ v7, v8, v11, v12]
  end

  def square_6
    [v9, v10, v13, v14]
  end

  def square_7
    [v10, v11, v14, v15]
  end

  def square_8
    [v11, v12, v15, v16]
  end

end

class TicTacToe < Processing::App

  attr_accessor :current_player, :model,:board, :mover

  def setup
    @model ||= TicTacToeModel.new(self)
    @board = BoardView.new(self, model)
    @mover = MoveView.new(self, model)
    @current_player = 'x'
    @key = ''
    @game_over = false
  end

  def draw
    board.create_board
  end

  def mouse_pressed
    model.all_squares.each do |square|
      if in_range?(mouse_x, mouse_y, square) && model.available_squares.include?(square)
        mover.draw_move(square)
        model.taken_squares << square
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

  def current_players_taken_squares
    if current_player == 'x'
      model.player_x_taken_squares
    else
      model.player_o_taken_squares
    end
  end

  def x_coordinate_range_for(square)
    (square[0][0]..square[1][0])
  end

  def y_coordinate_range_for(square)
    (square[0][1]..square[3][1])
  end

  def freeze_board
    model.empty_available_squares
  end

  def draw?
    model.available_squares.empty?
  end

  def check_for_win
    if draw?
      mover.print_draw
      end_game
      return self
    end
    model.winning_sets.each do |set|
      if set.all? {|square| current_players_taken_squares.include?(square)}
        mover.declare_winner(current_player)
        end_game
      end
    end
  end

  def end_game
    freeze_board
    play_again?
    @game_over = true
  end

  def play_again?
    textSize 16
    fill 256, 256, 254
    text("Press n to start a new game.", model.window_width*2/5, model.window_height*9/10)
  end

  def key_pressed
    if @game_over && key == "n"
      self.setup
      @model = TicTacToeModel.new(self)
    end
  end

end

TicTacToe.new
