require 'ruby-processing'

class TicTacToe < Processing::App

  def setup
    size 800, 800
    background(0, 0, 0)
  end

  def draw
    create_lines
  end

  def create_lines
    stroke 256,256,256
    line 301, 133, 301, 666
    line 488, 133, 488, 666
    line 133, 301, 666, 301
    line 133, 488, 666, 488

    # rect 133,133,533,533

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