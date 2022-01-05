describe ConnectFour do
  describe '#drop_piece' do
    subject(:game_drop) { described_class.new()}
    context 'when a player chooses an empty column' do
      it 'drops a piece down the choosen column' do
        expect(game_drop.drop_piece(player1, 3)).to eq([5, 2])
      end
    end

    context 'when a player picks a half full column' do
      it 'drops a piece down a half filled column' do
        expect(game_drop.drop_piece(player2, 3)).to eq([2, 2])
      end
    end

    context 'when a player tries to drop in a full column once and lets player try again' do
      it 'returns an error message and put piece in another chosen column' do
        expect(game_drop.drop_piece(player1, 3)).to eq('Column is full. Try again!')
        expect(game_drop.drop_piece(player1, 1)).to eq([5, 0])
      end
    end
  end

  describe '#end_turn' do
    subject(:game_turn) { described_class.new('player A', 'player B')}
    context 'when turn ends' do
      it 'changes current_player to the other player' do
        expect(end_turn(player1)).to eq(player2)
      end
    end
  end

  describe '#check_victory' do
    subject(:game_victory) {described_class.new()}
    context 'when 4 tiles are connected horizontally' do
      before do
        let(:h_board) { 
          [['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '⚫', '⚫', '⚫', '⚫', '_']]
        }
      end
      it 'returns victory for player 1' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(h_board)
      end
    end

    context 'when 4 tiles are connected vertically' do
      before do
        let(:v_board) { 
          [['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '⚪', '_', '_', '_', '_', '_'],
           ['_', '⚪', '_', '_', '_', '_', '_'],
           ['_', '⚪', '_', '_', '_', '_', '_'],
           ['_', '⚪', '_', '⚫', '⚫', '⚫', '_']]
        }
      end
      it 'returns victory for player 2' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(v_board)
      end
    end

    context 'when 4 tiles are connected diagonally' do
      before do
        let(:d_board) { 
          [['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['⚫', '⚪', '_', '_', '_', '_', '_'],
           ['⚪', '⚫', '_', '_', '_', '_', '_'],
           ['⚪', '⚪', '⚫', '_', '_', '_', '_'],
           ['⚪', '⚪', '⚪', '⚫', '⚫', '⚫', '_']]
        }
      end
      it 'returns victory for player 1' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(d_board)
      end
    end

    context 'when there is no winning condition' do
      before do
        let(:incomplete_board) { 
          [['_', '_', '_', '_', '_', '_', '_'],
           ['_', '_', '_', '_', '_', '_', '_'],
           ['_', '⚪', '_', '_', '_', '_', '_'],
           ['⚪', '⚫', '_', '_', '_', '_', '_'],
           ['⚪', '⚪', '⚫', '_', '_', '_', '_'],
           ['⚫', '⚪', '⚪', '⚫', '⚫', '⚫', '_']]
        }
      end
      it 'returns nil' do
        expect(game_victory.check_victory(incomplete_board)).to be_nil
      end
    end
  end
end