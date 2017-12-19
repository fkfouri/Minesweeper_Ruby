require 'matrix'

class Minesweeper
    def initialize(width, height, num_mines)
        @width = width
        @height = height
        @num_mines = num_mines
        @matrix = Matrix.zero(width, height)
        puts @matrix
     end

    def hello
       puts "Hello Ruby!"
    end

    def area
        puts @width * @height + 2
    end
end