require 'ruby-processing'
require 'set'

class BoardView

  attr_reader :window_width, :window_height, :app, :model,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize(app)
    @app ||= app
    @model ||= app.model
    app.background(0, 0, 0)
    app.size model.window_width, model.window_height
  end

  def create_board
    app.stroke 256,256,256
    create_grid
    create_borders
  end

  def create_grid
    app.line square_controller.v2[0], square_controller.v2[1], square_controller.v14[0], square_controller.v14[1]
    app.line square_controller.v3[0], square_controller.v3[1], square_controller.v15[0], square_controller.v15[1]
    app.line square_controller.v5[0], square_controller.v5[1], square_controller.v8[0], square_controller.v8[1]
    app.line square_controller.v9[0], square_controller.v9[1], square_controller.v12[0], square_controller.v12[1]
  end

  def create_borders
    app.line square_controller.v1[0], square_controller.v1[1], square_controller.v4[0], square_controller.v4[1]
    app.line square_controller.v4[0], square_controller.v4[1], square_controller.v16[0], square_controller.v16[1]
    app.line square_controller.v13[0], square_controller.v13[1], square_controller.v16[0], square_controller.v16[1]
    app.line square_controller.v1[0], square_controller.v1[1], square_controller.v13[0], square_controller.v13[1]
  end

end

class MoveView

  attr_reader :model, :squares, :app

  def initialize(app)
    @app ||= app
  end

  def draw_move(square)
    game_ruler = app.game_ruler
    render_x(square) if game_ruler.current_player == 'x'
    render_o(square) if game_ruler.current_player == 'o'
  end

  def print_draw
    @vertex_dude ||= app.vertex_dude
    app.textSize 16
    app.fill 256, 256, 254
    app.text("The game is a draw", vertex_dude.window_width*2/5, vertex_dude.window_height*1/10)
  end

  def print_winner(player)
    @vertex_dude ||= app.vertex_dude
    app.textSize 16
    app.fill 256, 256, 254
    app.text("#{player} is the winner!", vertex_dude.window_width*2/5, vertex_dude.window_height*1/10)
  end

  def print_play_again?
    @vertex_dude ||= app.vertex_dude
    textSize 16
    fill 256, 256, 254
    text("Press n to start a new game.", vertex_dude.window_width*2/5, vertex_dude.window_height*9/10)
  end

  def render_x(square)
    app.line square.ul[0]+10, square.ul[1]+10, square.lr[0]-10, square.lr[1]-10
    app.line square.ur[0]-10, square.ur[1]+10, square.ll[0]+10, squarell[1]-10
  end

  def render_o(square)
    app.fill 0, 0, 0, 50
    app.ellipse((square.ul[0]+square.lr[0])/2, (square.ul[1]+square.lr[1])/2, vertex_dude.window_width*1/5, vertex_dude.window_height*1/5)
  end
end

class TicTacToeModel

  attr_accessor :app, :all_squares

  def initialize(app, squares_in)
    @app = app
    @all_squares ||= squares_in
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

end

class Square

  attr_reader :ul, :ur, :ll, :lr

  def initialize(ul, ur, ll, lr)
    @ul = ul
    @ur = ur
    @ll = ll
    @lr = lr
  end

  def taken?
    model.available_squares.include?(self)
  end

  def in_range?(position)
    x_coordinate_range.include?(position[0]) && y_coordinate_range.include?(position[1])
  end

  def x_coordinate_range
    (ul[0]..ur[0])
  end

  def y_coordinate_range
    (ul[1]..ll[1])
  end

end

class VertexDude

  attr_reader :window_width, :window_height,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize
    set_window_size
    define_vertices
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
end

class SquareController

  attr_accessor :app, :model, :mover, :vertex_dude

  def initialize(app)
    @app = app
    @vertex_dude = app.vertex_dude
    set_window_size
    define_vertices
  end

  def take_if_available(position)
    square = find_square_by_position(position)

    if square.taken?
      return self
    end

    @model = app.model
    @mover = app.mover

    mover.draw_move(square)
    model.taken_squares << square
    current_players_taken_squares << square
  end

  def find_square_by_position(position)
    model.all_squares.find do |square|
      square.in_range?
    end
  end

  def square_0
    @square_0 ||= Square.new(vertex_dude.v1, vertex_dude.v2, vertex_dude.v5, vertex_dude.v6)
  end

  def square_1
    @square_1 ||= Square.new(vertex_dude.v2, vertex_dude.v3, vertex_dude.v6, vertex_dude.v7)
  end

  def square_2
    @square_2 ||= Square.new(vertex_dude.v3, vertex_dude.v4, vertex_dude.v7, vertex_dude.v8)
  end

  def square_3
    @square_3 ||= Square.new(vertex_dude.v5, vertex_dude.v6, vertex_dude.v9, vertex_dude.v10)
  end

  def square_4
    @square_4 ||= Square.new(vertex_dude.v6, vertex_dude.v7, vertex_dude.v10, vertex_dude.v11)
  end

  def square_5
    @square_5 ||= Square.new(vertex_dude.v7, vertex_dude.v8, vertex_dude.v11, vertex_dude.v12)
  end

  def square_6
    @square_6 ||= Square.new(vertex_dude.v9, vertex_dude.v10, vertex_dude.v13, vertex_dude.v14)
  end

  def square_7
    @square_7 ||= Square.new(vertex_dude.v10, vertex_dude.v11, vertex_dude.v14, vertex_dude.v15)
  end

  def square_8
    @square_8 ||= Square.new(vertex_dude.v11, vertex_dude.v12, vertex_dude.v15, vertex_dude.v16)
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

end

class GameRuler

  attr_reader :app, :model, :mover, :game_over

  def initialize(app)
    @app = app
    @model = app.model
    @mover = app.mover
    @current_player = 'x'
    @game_over = false
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

  def game_draw?
    model.available_squares.empty?
  end

  def check_for_win
    model.winning_sets.each do |set|
      if set.all? {|square| current_players_taken_squares.include?(square)}
        mover.print_winner(current_player)
        end_game
        return self
      end
    end

    if game_draw?
      mover.print_draw
      end_game
    end

  end

  def end_game
    freeze_board
    mover.print_play_again?
    game_over = true
  end

  def freeze_board
    model.empty_available_squares
  end

end

class TicTacToe < Processing::App

  attr_accessor :current_player, :model, :square_controller, :board, :mover, :game_ruler

  def setup
    @board = BoardView.new(self)
    @vertex_dude = VertexDude.new
    @square_controller = SquareController.new(self)
    @model ||= TicTacToeModel.new(self)
    @mover = MoveView.new(self)
    @game_ruler = GameRuler.new(self)
  end

  def draw
    board.create_board
  end

  def mouse_pressed
    position = [mouse_x, mouse_y]
    square_controller.take_if_available(position)
    check_for_win
    change_player
  end

  def key_pressed
    if game_ruler.game_over && key == "n"
      self.setup
      @model = TicTacToeModel.new(self)
    end
  end

end

TicTacToe.new
