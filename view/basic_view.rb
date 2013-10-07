require 'ruby-processing'

class TicTacToe < Processing::App
  attr_accessor :current_player
  def setup
    size 800, 800
    background(0, 0, 0)
    @current_player = 'x'
  end

  def draw
    create_lines
    # if @button
    #   render_x(square_5)
    # end
    # render_x(square_0)
    # render_x(square_1)
    # render_x(square_2)
    # render_x(square_3)
    # render_x(square_4)
    # render_x(square_5)
    # render_x(square_6)
    # render_x(square_7)
    # render_x(square_8)
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
      if x_coordinate_range_for(square).include?(mouse_x)  && y_coordinate_range_for(square).include?(mouse_y) && available_squares.include?(square)
        draw_square(square)
	taken_squares << square
      end
    end
    change_player
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

  def draw_square(square)
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
