require_relative 'Minesweeper'
require_relative 'PrettyPrinter'
require_relative 'simplePrinter'
require_relative 'gameTest'


=begin
width, height, num_mines = 6, 10, 10
myGame = Minesweeper.new(width, height, num_mines)
printer = PrettyPrinter.new
#puts myGame.board_state
puts printer.print(myGame.board_state)
=end


width, height, num_mines = 6, 6, 10
game = Minesweeper.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move or valid_flag
  printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
  printer.print(game.board_state)
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  PrettyPrinter.new.print(game.board_state(xray: true))
end