require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    size 800, 800
    background(0, 0, 0)
    @button = false
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
    target = [mouse_x, mouse_y]
    # case target
    # (x_coordinate_range_for(square_0).include?(mouse_x)  && y_coordinate_range_for(square).include?(mouse_y)
    #     draw_square(square_0)
      if mouse_x > square_1[0][0] && mouse_x < square_1[1][0] && mouse_y < square_1[3][1] && mouse_y > square_1[0][1]
        draw_square(square_1)
      end
      # when square_2[0][0] < target[0] < square_2[1][0] && square_2[0][1] < y < square_2[3][1]
      #   draw_square(square_2)
      # when square_3[0][0] < target[0] < square_3[1][0] && square_3[0][1] < y < square_3[3][1]
      #   draw_square(square_3)
      # when square_4[0][0] < target[0] < square_4[1][0] && square_4[0][1] < y < square_4[3][1]
      #   draw_square(square_4)
      # when square_5[0][0] < target[0] < square_5[1][0] && square_5[0][1] < y < square_5[3][1]
      #   draw_square(square_5)
      # when square_6[0][0] < target[0] < square_6[1][0] && square_6[0][1] < y < square_6[3][1]
      #   draw_square(square_6)
      # when square_7[0][0] < target[0] < square_7[1][0] && square_7[0][1] < y < square_7[3][1]
      #   draw_square(square_7)
      # when square_8[0][0] < target[0] < square_8[1][0] && square_8[0][1] < y < square_8[3][1]
      #   draw_square(square_8)
      # else
      # return
    # end
  end

  def draw_square(square)
    render_x(square) # if current_player_x?
    # render_o(square) if current_player_o?
  end

  def render_x(square)
    line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
  end

  def x_coordinate_range_for(square)
    (square[0][0]..square[1][0])
  end

  def y_coordinate_range_for(square)
    (square[0][1]..square[3][1])
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
