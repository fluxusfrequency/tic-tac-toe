require 'ruby-processing'
require 'set'

class BoardView

  attr_reader :app, :vertex_dude,
    :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8,
    :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def initialize(app)
    @app ||= app
    @vertex_dude = app.vertex_dude
    app.background(0, 0, 0)
    app.size vertex_dude.window_width, vertex_dude.window_height
  end

  def create_board
    app.stroke 256,256,256
    create_grid
    create_borders
  end

  def create_grid
    app.line vertex_dude.v2[0], vertex_dude.v2[1], vertex_dude.v14[0], vertex_dude.v14[1]
    app.line vertex_dude.v3[0], vertex_dude.v3[1], vertex_dude.v15[0], vertex_dude.v15[1]
    app.line vertex_dude.v5[0], vertex_dude.v5[1], vertex_dude.v8[0], vertex_dude.v8[1]
    app.line vertex_dude.v9[0], vertex_dude.v9[1], vertex_dude.v12[0], vertex_dude.v12[1]
  end

  def create_borders
    app.line vertex_dude.v1[0], vertex_dude.v1[1], vertex_dude.v4[0], vertex_dude.v4[1]
    app.line vertex_dude.v4[0], vertex_dude.v4[1], vertex_dude.v16[0], vertex_dude.v16[1]
    app.line vertex_dude.v13[0], vertex_dude.v13[1], vertex_dude.v16[0], vertex_dude.v16[1]
    app.line vertex_dude.v1[0], vertex_dude.v1[1], vertex_dude.v13[0], vertex_dude.v13[1]
  end

end

class MoveView

  attr_reader :model, :squares, :app, :game_ruler, :vertex_dude

  def initialize(app)
    @app ||= app
  end

  def draw_move(square)
    @game_ruler = app.game_ruler
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
    app.textSize 16
    app.fill 256, 256, 254
    app.text("Press n to start a new game.", vertex_dude.window_width*2/5, vertex_dude.window_height*9/10)
  end

  def render_x(square)
    @vertex_dude ||= app.vertex_dude
    app.line square.ul[0]+10, square.ul[1]+10, square.lr[0]-10, square.lr[1]-10
    app.line square.ur[0]-10, square.ur[1]+10, square.ll[0]+10, square.ll[1]-10
  end

  def render_o(square)
    @vertex_dude ||= app.vertex_dude
    app.fill 0, 0, 0, 50
    app.ellipse((square.ul[0]+square.lr[0])/2, (square.ul[1]+square.lr[1])/2, vertex_dude.window_width*1/5, vertex_dude.window_height*1/5)
  end
end

class TicTacToeModel

  attr_accessor :app, :all_squares

  def initialize(app, squares_in)
    @app = app
    @all_squares ||= squares_in
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
    [Set.new([all_squares[0], all_squares[1], all_squares[2]]),
    Set.new([all_squares[3], all_squares[4], all_squares[5]]),
    Set.new([all_squares[6], all_squares[7], all_squares[8]]),
    Set.new([all_squares[0], all_squares[3], all_squares[6]]),
    Set.new([all_squares[1], all_squares[4], all_squares[7]]),
    Set.new([all_squares[2], all_squares[5], all_squares[8]]),
    Set.new([all_squares[0], all_squares[4], all_squares[8]]),
    Set.new([all_squares[2], all_squares[4], all_squares[6]])]
  end

end

class Square

  attr_reader :ul, :ur, :ll, :lr, :app, :model

  def initialize(ul, ur, ll, lr,app)
    @ul = ul
    @ur = ur
    @ll = ll
    @lr = lr
    @app = app
  end

  def taken?
    @model = app.model
    !model.available_squares.include?(self)
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

  attr_accessor :app, :model, :mover, :vertex_dude, :game_ruler

  def initialize(app)
    @app = app
    @vertex_dude = app.vertex_dude
  end

  def take_if_available(position)
    square = find_square_by_position(position) || return
    if square.taken?
      return self
    end

    @model = app.model
    @mover = app.mover

    mover.draw_move(square)
    @model.taken_squares << square

    @game_ruler = app.game_ruler
    game_ruler.current_players_taken_squares << square
  end

  def find_square_by_position(position)
    app.model.all_squares.find do |square|
      square.in_range?(position)
    end
  end

  def square_0
    @square_0 ||= Square.new(vertex_dude.v1, vertex_dude.v2, vertex_dude.v5, vertex_dude.v6, app)
  end

  def square_1
    @square_1 ||= Square.new(vertex_dude.v2, vertex_dude.v3, vertex_dude.v6, vertex_dude.v7, app)
  end

  def square_2
    @square_2 ||= Square.new(vertex_dude.v3, vertex_dude.v4, vertex_dude.v7, vertex_dude.v8, app)
  end

  def square_3
    @square_3 ||= Square.new(vertex_dude.v5, vertex_dude.v6, vertex_dude.v9, vertex_dude.v10, app)
  end

  def square_4
    @square_4 ||= Square.new(vertex_dude.v6, vertex_dude.v7, vertex_dude.v10, vertex_dude.v11, app)
  end

  def square_5
    @square_5 ||= Square.new(vertex_dude.v7, vertex_dude.v8, vertex_dude.v11, vertex_dude.v12, app)
  end

  def square_6
    @square_6 ||= Square.new(vertex_dude.v9, vertex_dude.v10, vertex_dude.v13, vertex_dude.v14, app)
  end

  def square_7
    @square_7 ||= Square.new(vertex_dude.v10, vertex_dude.v11, vertex_dude.v14, vertex_dude.v15, app)
  end

  def square_8
    @square_8 ||= Square.new(vertex_dude.v11, vertex_dude.v12, vertex_dude.v15, vertex_dude.v16, app)
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

  attr_reader :app, :model, :mover, :game_over, :current_player

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
    if @current_player == 'x'
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
    @game_over = true
    freeze_board
    mover.print_play_again?
  end

  def freeze_board
    model.empty_available_squares
  end
end

class TicTacToe < Processing::App

  attr_accessor :current_player, :model, :square_controller, :board, :mover, :game_ruler,
    :vertex_dude

  def setup
    @vertex_dude = VertexDude.new
    @board = BoardView.new(self)
    @square_controller = SquareController.new(self)
    @model ||= TicTacToeModel.new(self, square_controller.all_squares)
    @mover = MoveView.new(self)
    @game_ruler = GameRuler.new(self)
  end

  def clear_attrs
    @vertex_dude = nil
    @board = nil
    @square_controller = nil
    @model = nil
    @mover = nil
    @game_ruler = nil
  end

  def draw
    board.create_board
  end

  def mouse_pressed

    # this avoids one weird bug where first click is 0,0
    if mouse_x == 0 && mouse_y == 0
      return
    end
    position = [mouse_x, mouse_y]
    square_controller.take_if_available(position)
    game_ruler.check_for_win
    game_ruler.change_player
  end

  def key_pressed
    puts key.inspect
    if game_ruler.game_over && key == "n"
      clear_attrs
      self.setup
    end
  end

end

TicTacToe.new
