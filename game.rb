require 'matrix'

#http://www.programering.com/a/MTNykzMwATA.html
class Minesweeper
    def initialize(width, height, num_mines, test = nil)
        @width = width
        @height = height
        @num_mines = num_mines
        @isTest = false
        @stillPlaying = true
        @findAll = 0
        @lastSelect = nil

        #verifica se eh um teste
        unless test.nil? 
            num_mines = test.x.length
            @num_mines = num_mines
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
                elements[uid] = {"x"=> x, "y"=> y, "tipo"=>"bomb", "flag" =>0, "find" => 0, "show" => '.', "value" => "#"}
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
                            elements[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>0, "find" => 0, "show" => '.', "value" => elements[nuid]["value"] + 1}
                        else
                            elements[nuid] = {"x"=> i, "y"=> j, "tipo"=>"neighbor", "flag" =>0, "find" => 0, "show" => '.', "value" => 1}
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
                    elements[nuid]= {"x"=> i, "y"=> j, "tipo"=>"zero", "flag" =>0, "find" => 0, "show" => '.', "value" => 0}
                end           
            end
        end

        @elements = elements
    end

    #retorna o tamanho/quantidade de campos do jogo
    def quantityFields
        return @elements.length
    end

    def board_state
        outStruct = Struct.new(:width, :height, :elements, :board_format)
        out = outStruct.new
        out.width = @width
        out.height = @height
        out.elements = @elements
        out.board_format = {unknown_cell: '.', clear_cell: '', bomb: '#', flag: 'F'}
        return out# @elements
    end


    #set flag, somente poe flag se item nao encontrado
    def flag(x,y)
        cell = @elements["#{x}-#{y}"]

        if @stillPlaying == false
            return false
        elsif cell["find"] == 0 
            if cell["flag"] == 0
                cell["flag"] = 1
                cell["show"] = 'F'
            else
                cell["flag"] = 0
                cell["show"] = '.'
            end
            return true
        end

        return false
    end


    #Acao de escolher uma coluna
    def play(x,y)
        cell = @elements["#{x}-#{y}"]

        #puts cell
        out = false
        if @stillPlaying == false or cell["flag"]==1 or cell["find"] == 1 #nao permite selecionar uma celula com flag ou ja descoberta
            return false
        elsif cell["flag"]==0 and cell["tipo"] == "bomb"
            @stillPlaying = false
            cell["find"] = 1
            @findAll +=1
            cell["show"] = '#'
            @lastSelect = cell["show"]
            return true
        elsif cell["flag"]==0 and cell["tipo"] == "zero"
            cell["find"] = 1
            @findAll +=1
            cell["show"] = ''
            #cell["value"] = ''
            @lastSelect = cell["show"]
            openArea(x , y)
            return true
        elsif cell["flag"]==0 and cell["tipo"] == "neighbor"
            cell["find"] = 1 
            @findAll +=1
            cell["show"] = cell["value"]
            @lastSelect = cell["value"]
            return true
        end
    end

    def showValue
        return "[#{@lastSelect}]" 
    end
    
    #retorna true se o jogo acabou com vitoria
    def victory
        if @findAll + @num_mines >= quantityFields
            return true
        else
            return false
        end
    end
    
    #retorna true (ainda em jogo), false (game over por derrota ou por vitoria)
    def still_playing
        if victory == true
            @stillPlaying = false
        end
        return @stillPlaying 
    end       
    
    #responsavel por abrir uma area de Zeros a partir do ponto selecionado
    private
    def openArea(x, y)
        for i in x-1..x+1
            for j in y-1..y+1
                cell = @elements["#{i}-#{j}"]
                if i >=0 and j >=0 and i <= @width-1 and j <= @height-1 and cell["find"] == 0 and cell["flag"] == 0
                    if  cell["tipo"] == "zero"
                        cell["find"] = 1
                        @findAll +=1
                        cell["show"] = ''
                        #cell["value"] = ''
                        openArea(i, j)
                    else
                        cell["find"] = 1
                        cell["show"] = cell["value"] 
                        @findAll +=1
                    end
                end
            end
        end
    end
    
    
end