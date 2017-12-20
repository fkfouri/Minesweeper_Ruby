require 'matrix'

class PrettyPrinter

    def print(board_state)
        show = "value"
        #show = "flag"
        #show = "find"
        matrix = Matrix.build(board_state.width, board_state.height) {|x, y| board_state.elements.has_key?("#{x}-#{y}")? (board_state.elements["#{x}-#{y}"]["tipo"]!="bomb"? board_state.elements["#{x}-#{y}"][show].to_s.rjust(3).ljust(6) : "bomb".rjust(3).ljust(6))  : 88 }
        
        out =[]
        for i in 0..matrix.column_count-1
            out.push matrix.column(i)
        end
        return out
    end

end