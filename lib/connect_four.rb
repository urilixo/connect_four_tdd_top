# frozen_string_literal: true

class ConnectFour
  attr_accessor :board, :player1, :player2, :player_turn, :victory
  

  def initialize(player1 = nil, player2 = nil)
    @player1 = player1
    @player2 = player2
    @player_turn = @player1
    @board = create_board
    @victory = false
  end

  def drop_piece(player, column)
    column -= 1
    piece = player == @player1 ? '♎' : '♊'
    (0..5).each do |i|
      next if @board[i + 1] == '⚪'

      if (@board[i + 1].nil? || @board[i + 1][column] != '⚪') && @board[i][column] == '⚪'
        @board[i][column] = piece and return [i, column]
      end
    end
    'Column is full. Try again!'
  end

  def end_turn(player)
    player == @player1 ? @player2 : @player1
  end

  def show_board
    @board.each { |row| p row.join }
  end

  def check_victory(board = nil, transposed: false)
    board = @board if board.nil?

    board.each { |row| return game_end if row.join.include?('♊♊♊♊') || row.join.include?('♎♎♎♎') }
    check_victory(board.transpose, transposed: true) unless transposed
    check_diagonals(board) unless transposed

    nil
  end

  def play
    intro
    puts 'Type Player 1 name: '
    self.player1 = player_name
    puts 'Type Player 2 name: '
    self.player2 = player_name
    game_loop
  end

  private

  def intro
    puts <<~HEREDOC
                         --Connect Four--

      You need two players for this game, first player () to connect
         four pieces, in a row, vertically or diagonally wins!

                 Player 1: ♊        Player 2: ♎

                    Press any key to continue.
    HEREDOC
    gets.chomp
  end

  def game_loop
    turn_count = 0
    0.upto(41) do |counter|
      puts "Player #{@player_turn}'s turn." unless @player_turn.nil?
      column = valid_movement
      drop_piece(@player_turn, column)
      @player_turn = end_turn(@player_turn)
      puts `clear`
      show_board
      check_victory
      break if @victory == true

      turn_count += 1
      game_end(draw: true) if counter == 41
    end
  end

  def draw
    puts 'Game over. Draw!'
  end

  def valid_movement
    puts 'Pick a column from 1 to 7 to place your piece!'
    movement = gets.chomp
    return valid_movement unless ('1'..'7').include?(movement)

    movement.to_i
  end

  def check_diagonals(board)
    padding = [*0..(board.length - 1)].map { |i| [nil] * i }
    padded = padding.reverse.zip(board).zip(padding).map(&:flatten)

    check_victory(padded.transpose.map(&:compact), transposed: true)
  end

  def player_name(name = nil)
    name = gets.chomp if name.nil?
    name
  end

  def game_end(draw: false)
    puts 'Game over. Draw!' if draw
    puts "Victory from #{end_turn(@player_turn)}!!" unless draw
    @victory = true
  end

  def create_board
    [
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪],
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪],
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪],
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪],
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪],
      %w[⚪ ⚪ ⚪ ⚪ ⚪ ⚪ ⚪]
    ]
  end
end
