class BoardView < Processing::App

  attr_reader :window_width, :window_height, :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8, :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def setup

  end

  def print_draw
    textSize 16
    fill 256, 256, 254
    text("The game is a draw", 310, 65)
  end

  def declare_winner(player)
    textSize 16
    fill 256, 256, 254
    text("#{player} is the winner!", 310, 65)
  end

  def render_x(square)
    line square[0][0]+10, square[0][1]+10, square[3][0]-10, square[3][1]-10
    line square[1][0]-10, square[1][1]+10, square[2][0]+10, square[2][1]-10
  end

  def render_o(square)
    fill 0, 0, 0, 50
    ellipse (square[0][0]+square[3][0])/2, (square[0][1]+square[3][1])/2, 148, 148
  end

end