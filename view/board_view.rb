class BoardView < Processing::App

  attr_reader :window_width, :window_height, :v1, :v2, :v3, :v4, :v5, :v6, :v7, :v8, :v9, :v10, :v11, :v12, :v13, :v14, :v15, :v16

  def setup
    background(0, 0, 0)
    set_window_size(800,800)
    size @window_width, @window_height
    define_vertices
  end

  def draw
    create_board
  end

  def create_board
    stroke 256,256,256
    create_grid
    create_borders
  end

  def create_grid
    line v2[0], v2[1], v14[0], v14[1]
    line v3[0], v3[1], v15[0], v15[1]
    line v5[0], v5[1], v8[0], v8[1]
    line v9[0], v9[1], v12[0], v12[1]
  end

  def create_borders
    line v1[0], v1[1], v4[0], v4[1]
    line v4[0], v4[1], v16[0], v16[1]
    line v13[0], v13[1], v16[0], v16[1]
    line v1[0], v1[1], v13[0], v13[1]
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

  def set_window_size(width=800, height=800)
    @window_width = width
    @window_height = height
  end

end