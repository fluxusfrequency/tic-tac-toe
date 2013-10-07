require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    background(0, 0, 0)
    ellipse_mode CENTER
    rect_mode CENTER
    smooth
  end

  def draw
  end

end

TicTacToe.new(:width => 800, :height => 800,
  :title => "TicTacToe", :full_screen => false)
