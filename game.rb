require 'matrix'

#http://www.programering.com/a/MTNykzMwATA.html
class Minesweeper
    def initialize(width, height, num_mines)
        @width = width
        @height = height
        @num_mines = num_mines
        
        raise "A quantidade de minas supera o tamanho do campo. " if @num_mines > @width * @height  

        bombs = Hash.new
        neighbor = Hash.new
        elements = Hash.new

        while num_mines > 0
            x = rand(width) #+ 1
            y = rand(height) #+ 1

            uid = x.to_s + "-" + y.to_s
            if not bombs.has_key?(uid)
                bombs[uid] = {"x"=> x, "y"=> y, "tipo"=>"bomb", "flag" =>"0", "value" => 0}
                
                num_mines -= 1
                
                #trecho que circunda o ponto da bomba, vizinhos
                for i in x-1..x+1
                  for j in y-1..y+1
                    if i >=0 and j >=0 and i <= width-1 and j <=height-1 and not (i == x and j == y )
                      #puts "#{i} #{j}"
                      nuid = i.to_s + "-" + j.to_s
                      #neighbor.has_key?(nuid)?neighbor[nuid] += 1 : neighbor[nuid]=1
                      if neighbor.has_key?(nuid)
                        neighbor[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>"0", "value" => neighbor[nuid]["value"] + 1}
                      else
                        neighbor[nuid]= {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>"0", "value" => 1}
                      end
                    end
                  end
                end
            end
        end

        #puts neighbor
        puts "==============="
        #puts bombs


        @matrix = Matrix.build(width, height)  { |x1, y1| bombs.has_key?(x1.to_s + "-" + y1.to_s) ? bombs[x1.to_s + "-" + y1.to_s]["tipo"]: neighbor.has_key?(x1.to_s + "-" + y1.to_s)? neighbor[x1.to_s + "-" + y1.to_s]["value"] : 0 }
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