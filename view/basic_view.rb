require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    size 800, 800
    background(0, 0, 0)
    smooth
    create_lines
  end

  def draw
    stroke 256,256,256
    create_lines
    render_x(square_0)
    render_x(square_1)
    render_x(square_2)
    render_x(square_3)
    render_x(square_4)
  end

  def create_lines
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

  def render_x(square)
    line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
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
end

TicTacToe.new(:width => 800, :height => 800,
  :title => "TicTacToe", :full_screen => false)
