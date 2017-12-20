require 'test/unit'
load 'game.rb'

width, height, num_mines = 6, 6, 10
testStruct = Struct.new(:x, :y)
test = testStruct.new
test.x= [1,1,2,2]
test.y =[1,2,2,3]

#test = [{1,1}] #,(1,2),(2,2)]
object = Minesweeper.new(width, height, num_mines, test)
#object.hello
#object.area
#puts object.quantityFields

#your_name = "Terrence"

#puts "Hello #{your_name}"