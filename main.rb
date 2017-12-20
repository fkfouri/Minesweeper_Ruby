require_relative 'game'
require_relative 'PrettyPrinter'
require_relative 'gameTest'

=begin

width, height, num_mines = 10, 6, 10
myGame = Minesweeper.new(width, height, num_mines)
printer = PrettyPrinter.new
#puts myGame.board_state
puts printer.print(myGame.board_state)


my_tests = GameTest.new
g = my_tests.start
printer = PrettyPrinter.new
puts printer.print(g.board_state)
puts "=========================================================="
g.play(4,2)
g.play(1,5)
puts printer.print(g.board_state)
puts "=========================================================="

g.play(0,0)
g.play(0,1)
g.play(0,2)
g.play(1,0)

puts printer.print(g.board_state)
puts g.victory
=end


#my_tests = Test::Unit::TestSuite.new("Teste do MinesWeeper")
#my_tests << GameTest.new('firstTest')
#my_tests << GameTest.new('test_10')
#my_tests << GameTest.new('test_20')
#my_tests << GameTest.new('test_30')
#Test::Unit::UI::Console::TestRunner.run(my_tests)


