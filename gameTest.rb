require_relative 'game'
require_relative 'PrettyPrinter'
require_relative 'GameTest'
require "test/unit"
require 'test/unit/ui/console/testrunner'

#teste unitario
class GameTest < Test::Unit::TestCase
    attr_reader :name
    
    def start
        width, height, num_mines = 6, 6, 10
        testStruct = Struct.new(:x, :y)
        test = testStruct.new
        test.x= [1,1,2,3]
        test.y =[1,2,2,5]
        
        #test = [{1,1}] #,(1,2),(2,2)]
        @g = Minesweeper.new(width, height, num_mines, test)
        return @g
    end
    
    def test_00()
        g = start
        assert_equal(36, g.quantityFields)
    end

    def test_10 # Seleciona uma celula zero, tenta colocar um flag depois de descoberta, tenta clicar na celula
        g = start
        assert_equal(true, g.play(5,4)) # => Esperado true, jogada validada, pois clico num celula zero'
        assert_equal(false, g.flag(5,4)) # => Esperado false, jogada nao validada, celula ja descoberta'
        assert_equal(false, g.play(5,4)) # => Esperado false, pois a celula ja foi clicada anteriormente '
    end

    def test_20 # boto uma flag em cima de uma bomba, e tento clicar na bomba
        @g = start
        assert_equal(true, @g.flag(1,1)) # => Esperado true como jogada validada, para colocar uma flag '
        assert_equal(false, @g.play(1,1)) # => Esperado false (clico em cima de uma bomba, mas o flag nao permite a jogada)'
    end

    def test_30 # continuacao do test_20, porem, removo a flag e testo se explore a bomba
        test_20
        assert_equal(true, @g.still_playing) # => em Jogo
        assert_equal(true, @g.flag(1,1)) # => Esperado true como jogada validada, removo a flag de uma bomba '
        assert_equal(true,  @g.play(1,1)) # => BOMBA - clico na bomba, que anteriormente estava com flag'
        assert_equal(false, @g.still_playing) # => Game Over
    end
end

#my_tests = Test::Unit::TestSuite.new("Teste do MinesWeeper")
#my_tests << GameTest.new('firstTest')
#my_tests << GameTest.new('test_10')
#my_tests << GameTest.new('test_20')
#my_tests << GameTest.new('test_30')
#Test::Unit::UI::Console::TestRunner.run(my_tests)