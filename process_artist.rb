# require 'ruby-processing'

# class MySketch < Processing::App
#   attr_accessor :queue

#   def setup
#     background(0, 0, 0)
#     @brush_width = 10
#     @brush_height = 10
#     ellipse_mode CENTER
#     rect_mode CENTER
#     smooth
#   end

#   def draw
#   end

#   def key_pressed
#     warn "A key was pressed! #{key.inspect}"
#     @queue ||= ""
#     if key.to_s != "\n" || "65535"
#       @queue = @queue + key
#     else
#       warn "Time to run the command: #{queue}"
#       run_command(@queue)
#       @queue = ""
#     end
#   end

#   def run_command(command)
#     puts "Running Command #{command}"
#     if command.start_with? 'b'
#         puts "Changing background!"
#         background_color_command(command)
#     elsif command.start_with? 'f'
#       fill_color_command(command)
#     elsif command.start_with? '='
#       @brush_width = @brush_width + 10
#       @brush_height = @brush_height + 10
#     elsif command.eql?("-")
#       @brush_width -= 1
#       @brush_height -= 1
#     else
#       return
#     end

#   end

#   def background_color_command(command)
#     set_color(command)
#     redraw_background(@r,@g,@b)
#     reset_queue
#   end

#   def set_color(command)
#     command_parts = command.split(",")
#     @r = command_parts[0][1..3].to_i
#     @g = command_parts[1][0..2].to_i
#     @b = command_parts[2][0..2].to_i
#   end

#   def redraw_background(*colors)
#     r, g, b = colors[0], colors[1], colors[2]
#     background(r,g,b)
#   end

#   def fill_color_command(command)
#     set_color(command)
#   end

#   def mouse_pressed
#     @rand_rgb = random_rgb
#     fill(@rand_rgb[0].to_i, @rand_rgb[1].to_i, @rand_rgb[2].to_i)
#     ellipse(mouse_x, mouse_y, @brush_width, @brush_height)
#   end

#   def mouse_dragged
#     fill(@rand_rgb[0].to_i, @rand_rgb[1].to_i, @rand_rgb[2].to_i)
#     ellipse(mouse_x, mouse_y, @brush_width, @brush_height)
#   end

#   def mouse_released
#   end

#   private

#   def reset_queue
#     queue = []
#   end

#   def random_rgb
#     r, g, b = rand(256), rand(256), rand(256)
#     [r,g,b]
#   end

# end

# MySketch.new(:width => 800, :height => 800,
#   :title => "ProcessArtist", :full_screen => false)