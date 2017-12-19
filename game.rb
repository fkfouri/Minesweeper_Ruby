require 'matrix'

#http://www.programering.com/a/MTNykzMwATA.html
class Minesweeper
    def initialize(width, height, num_mines)
        @width = width
        @height = height
        @num_mines = num_mines
    

        bombs = Hash.new

        while num_mines > 0
            x = rand(width) + 1
            y = rand(height) + 1

            uid = x.to_s + "-" + y.to_s
            if  not bombs.has_key?(uid)
                bombs[uid] = {"x": x, "y":y}
                num_mines -= 1
            end
        end

        puts bombs

        @matrix = Matrix.build(width, height)  { |x, y| bombs.has_key?(x.to_s + "-" + y.to_s) ? "Bomb: " + x.to_s + "x" + y.to_s : 0 }
            #@matrix = Matrix.build(width, height)  { |row, col| Random.rand(num_mines) }
       # @matrix = Matrix.zero(width, height) 

        puts @matrix
     end

    def hello
       puts "Hello Ruby!"
    end

    def area
        puts @width * @height + 2
    end
end