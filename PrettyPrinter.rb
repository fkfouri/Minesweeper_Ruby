require 'matrix'
require 'terminal-table'

class PrettyPrinter

    def print(board_state)
        #show = "value"
        show = "show"
        #show = "flag"
        #show = "find"

        #http://www.programering.com/a/MTNykzMwATA.html
        matrix = ''


        #Exibe xray se o jogo tiver terminado
        if board_state.input != nil and board_state.input[:xray] == true and board_state.stillPlaying == false
            matrix = Matrix.build(board_state.width, board_state.height) {|x, y|  board_state.elements["#{x}-#{y}"]["tipo"]!="bomb"? board_state.elements["#{x}-#{y}"][show].to_s.rjust(3).ljust(5) : '#'.rjust(3).ljust(5)  }
        else

            #matrix = Matrix.build(board_state.width, board_state.height) {|x, y| board_state.elements.has_key?("#{x}-#{y}")? (board_state.elements["#{x}-#{y}"]["tipo"]!="bomb"? board_state.elements["#{x}-#{y}"][show].to_s.rjust(3).ljust(6) : "bomb".rjust(3).ljust(6))  : 88 }
            #matrix = Matrix.build(board_state.width, board_state.height) {|x, y| (board_state.elements["#{x}-#{y}"]["flag"]!=1? board_state.elements["#{x}-#{y}"][show].to_s.rjust(3).ljust(5) : "F".to_s.rjust(3).ljust(5)) }
            matrix = Matrix.build(board_state.width, board_state.height) {|x, y|  board_state.elements["#{x}-#{y}"][show].to_s.rjust(3).ljust(5)  }
        end

        ## Fomato tipo Vetor
        #outVector =[]
        #for i in 0..matrix.column_count-1
        #    outVector.push matrix.column(i)
        #end
        #puts outVector

        #https://github.com/tj/terminal-table
        table = Terminal::Table.new do |t|
            t.style = {:all_separators => true}
            for i in 0..matrix.column_count-1
                t.add_row matrix.column(i).to_a #line
                #puts line
            end
        end
        puts table
    end

end