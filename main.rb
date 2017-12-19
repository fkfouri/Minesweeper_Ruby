
load 'game.rb'

width, height, num_mines = 6, 6, 8
object = Minesweeper.new(width, height, num_mines)
object.hello
object.area

your_name = "Terrence"

puts "Hello #{your_name}"