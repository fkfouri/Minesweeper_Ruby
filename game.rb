require 'matrix'

#http://www.programering.com/a/MTNykzMwATA.html
class Minesweeper
    def initialize(width, height, num_mines, test = nil)
        @width = width
        @height = height
        @num_mines = num_mines
        @isTest = false
        @stillPlaying = true

        #verifica se eh um teste
        unless test.nil? 
            num_mines = test.x.length
            @isTest = true
        end
        
        #levanta uma exception
        raise "A quantidade de minas supera o tamanho do campo. " if @num_mines > @width * @height  

        elements = Hash.new

        #dicionario de minas
        while num_mines > 0
            x = rand(width) #+ 1
            y = rand(height) #+ 1

            #para o caso de teste
            if @isTest
                x,y = test.x.shift.to_i, test.y.shift.to_i
            end

            uid = x.to_s + "-" + y.to_s
            if not elements.has_key?(uid)
                #puts uid
                elements[uid] = {"x"=> x, "y"=> y, "tipo"=>"bomb", "flag" =>0, "find" => 0, "value" => 0}
                 num_mines -= 1
            end
        end



        #dicionario de vizinhos
        #trecho que circunda o ponto da bomba, vizinhos
        bombs = elements.clone #faco um clone para que seja possivel iterar
        bombs.each do |key, value|
            x = value["x"]
            y = value["y"]

            for i in x-1..x+1
                for j in y-1..y+1
                    nuid = i.to_s + "-" + j.to_s
                    if i >=0 and j >=0 and i <= width-1 and j <=height-1 and not (i == x and j == y ) and not bombs.has_key?(nuid)
                        #elements.has_key?(nuid)?elements[nuid] += 1 : elements[nuid]=1
                        if elements.has_key?(nuid) and elements[nuid]["tipo"]=="neighbor"
                            elements[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>0, "find" => 0, "value" => elements[nuid]["value"] + 1}
                        else
                            elements[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>0, "find" => 0, "value" => 1}
                        end
                    end
                end
            end
        end

        
        #dicionario de Zeros, devido necessidade de flag
        for i in 0..width-1
            for j in 0..height-1
                nuid = i.to_s + "-" + j.to_s
                if not elements.has_key?(nuid)
                    elements[nuid]= {"x"=> i, "y"=> j, "tipo"=>"zero", "flag" =>0, "find" => 0, "value" => 0}
                end           
            end
        end

        
        #puts "==============="
        #puts elements

        @elements = elements
        @matrix = Matrix.build(width, height)  { |x1, y1| elements.has_key?(x1.to_s + "-" + y1.to_s)? (elements[x1.to_s + "-" + y1.to_s]["tipo"]!="bomb"? elements[x1.to_s + "-" + y1.to_s]["value"].to_s.rjust(3).ljust(6)  : "bomb".rjust(3).ljust(6))  : 88 }
            #@matrix = Matrix.build(width, height)  { |row, col| Random.rand(num_mines) }
       # @matrix = Matrix.zero(width, height) 

        #puts @matrix
    end

    #retorna o tamanho/quantidade de campos do jogo
    def quantityFields
        return @elements.length
    end

    def board_state
        outStruct = Struct.new(:width, :height, :elements)
        out = outStruct.new
        out.width = @width
        out.height = @height
        out.elements = @elements
        return out# @elements
    end

    #retorna true (ainda em jogo), false (game over por derrota ou por vitoria)
    def still_playing
        return @stillPlaying 
    end

    #set flag, somente poe flag se item nao encontrado
    def flag(x,y)
        nuid = x.to_s + "-" + y.to_s
        cell = @elements[nuid]

        out = false
        if @stillPlaying == false
            return false
        elsif cell["find"] == 0 
            out= true
            if cell["flag"] == 0
                cell["flag"] = 1
            else
                cell["flag"] = 0
            end
        end
        @elements[nuid] = cell
        return out
    end



    def play(x,y)
        nuid = x.to_s + "-" + y.to_s
        cell = @elements[nuid]

        #puts cell
        out = false
        if @stillPlaying == false or cell["flag"]==1 or cell["find"] == 1 #nao permite selecionar uma celula com flag ou ja descoberta
            return false
        elsif cell["flag"]==0 and cell["tipo"] == "bomb"
            @stillPlaying = false
            cell["find"] = 1
            out = true
        elsif cell["flag"]==0 and cell["tipo"] == "zero"
            out = true
            cell["find"] = 1
            cell["value"] = ''
            puts "=====> x = #{x} and y = #{y}"
            openArea(x , y)
        end

        #@elements[nuid] = cell

        return out
    end
    
    
    #responsavel por abrir uma area de Zeros a partir do ponto selecionado
    def openArea(x, y)
        for i in x-1..x+1
            for j in y-1..y+1
                nuid = "#{i}-#{j}"
                cell = @elements[nuid]
                if i >=0 and j >=0 and i <= @width-1 and j <= @height-1 and cell["find"] == 0
                    if  cell["tipo"] == "zero"
                        cell["find"] = 1
                        cell["value"] = ''
                        openArea(i, j)
                    else
                        @elements[nuid]["find"] = 1
                    end
                end
            end
        end
        
    end
    
    
end