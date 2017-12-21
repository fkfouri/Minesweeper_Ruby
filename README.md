# Minesweeper Ruby

## Introdução

Este é um desenvolvimento em Ruby do engine tradicional jogo Campo Minado "MinesWeeper".

O código executável pode ser acessado no endereço => https://repl.it/@fkfouri/Minesweeper

## Métodos

Os seguintes métodos foram implementados:
-  `play(x,y)` Executa a açao de selecionar um campo da coordenada X e Y 
- `quantityFields()` Retorna a quantidade de campos do jogo
-  `flag(x,y)`Coloca uma flag na cordenada X e Y
- `showValue()` Exibe o resultado da ultima ação válida
- `victory()` Exibe uma saída booleana se o jogador venceu a partida
- `still_playing()` Exibe uma saída booleana informando se a partida ainda está acontendo
- `board_state()` Esta é uma saída que retorna uma representação atual do tabuleiro. Este método aceita um pedido de raio-X somente se o jogo terminar. `board_state({xray: true})`

## Exemplo de Uso

```
width, height, num_mines = 6, 6, 10
game = Minesweeper.new(width, height, num_mines)

while game.still_playing?
  valid_move = game.play(rand(width), rand(height))
  valid_flag = game.flag(rand(width), rand(height))
  if valid_move or valid_flag
  printer = (rand > 0.5) ? SimplePrinter.new : PrettyPrinter.new
  printer.print(game.board_state)
  end
end

puts "Fim do jogo!"
if game.victory?
  puts "Você venceu!"
else
  puts "Você perdeu! As minas eram:"
  PrettyPrinter.new.print(game.board_state(xray: true))
end
```