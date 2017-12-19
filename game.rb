require 'matrix'

#http://www.programering.com/a/MTNykzMwATA.html
class Minesweeper
    def initialize(width, height, num_mines)
        @width = width
        @height = height
        @num_mines = num_mines
        
        raise "A quantidade de minas supera o tamanho do campo. " if @num_mines > @width * @height  

        elements = Hash.new

        while num_mines > 0
            x = rand(width) #+ 1
            y = rand(height) #+ 1

            uid = x.to_s + "-" + y.to_s
            if not elements.has_key?(uid)
                elements[uid] = {"x"=> x, "y"=> y, "tipo"=>"bomb", "flag" =>"0", "value" => 0}
                
                num_mines -= 1
                
                #trecho que circunda o ponto da bomba, vizinhos
                for i in x-1..x+1
                  for j in y-1..y+1
                    if i >=0 and j >=0 and i <= width-1 and j <=height-1 and not (i == x and j == y )
                      #puts "#{i} #{j}"
                      nuid = i.to_s + "-" + j.to_s
                      #elements.has_key?(nuid)?elements[nuid] += 1 : elements[nuid]=1
                      if elements.has_key?(nuid)
                        elements[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>"0", "value" => elements[nuid]["value"] + 1}
                      else
                        elements[nuid]= {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>"0", "value" => 1}
                      end
                    end
                  end
                end
            end
        end

        #puts neighbor
        puts "==============="
        #puts bombs


        @matrix = Matrix.build(width, height)  { |x1, y1| elements.has_key?(x1.to_s + "-" + y1.to_s)? (elements[x1.to_s + "-" + y1.to_s]["tipo"]!="bomb"? elements[x1.to_s + "-" + y1.to_s]["value"] : "bomb")  : 0 }
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