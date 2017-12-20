require 'matrix'

class PrettyPrinter

    def print(board_state)
        matrix = Matrix.build(board_state.width, board_state.height)  { |x1, y1| board_state.elements.has_key?(x1.to_s + "-" + y1.to_s)? (board_state.elements[x1.to_s + "-" + y1.to_s]["tipo"]!="bomb"? board_state.elements[x1.to_s + "-" + y1.to_s]["value"].to_s.rjust(3).ljust(6) : "bomb".rjust(3).ljust(6))  : 88 }
        
        out =[]
        for i in 0..matrix.row_count-1
            out.push matrix.row(i)
        end
        return out
    end

end
