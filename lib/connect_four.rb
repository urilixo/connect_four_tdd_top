class ConnectFour
  attr_reader :player1, :player2, :board

  def initialize(player1 = nil, player2 = nil)
    @player1 = player_name(player1)
    @player2 = player_name(player2)
    @player_turn = @player1
    @board = create_board
  end

  def drop_piece(player, column)
    column -= 1
    piece = player == @player1 ? '⚫' : '⚪'
    (0..5).each do |i|
      next if @board[i + 1] == '_'

      if (@board[i + 1].nil? || @board[i + 1][column] != '_') && @board[i][column] == '_'
        @board[i][column] = piece and return [i, column]
      end
    end
    'Column is full. Try again!'
  end

  def end_turn(player)
    player == @player1 ? @player2 : @player1
  end

  def check_victory
  end

  def player_name(name = nil)
    name = gets.chomp if name.nil?
    name
  end

  def create_board
    [
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _]
    ]
  end
end


