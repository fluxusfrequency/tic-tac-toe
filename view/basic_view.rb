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
  end

  def create_lines
    # line 150, 150, 150, 600
    line 301, 133, 301, 666
    line 488, 133, 488, 666
    line 133, 301, 666, 301
    line 133, 488, 666, 488

    # rect 133,133,533,533

  end

end

TicTacToe.new(:width => 800, :height => 800,
  :title => "TicTacToe", :full_screen => false)
