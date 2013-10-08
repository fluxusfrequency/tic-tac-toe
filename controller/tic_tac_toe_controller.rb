class TicTacToeController

  attr_accessor :current_player

  def initialize
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
