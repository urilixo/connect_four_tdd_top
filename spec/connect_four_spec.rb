require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#drop_piece' do
    subject(:game_drop) { described_class.new('p1', 'p2')}
    context 'when a player chooses an empty column' do
      it 'drops a piece down the choosen column' do
        expect(game_drop.drop_piece(game_drop.player1, 3)).to eq([5, 2])
      end
    end

    context 'when a player picks a half full column' do
      before do
        game_drop.drop_piece(game_drop.player1, 3)
        game_drop.drop_piece(game_drop.player2, 3)
        game_drop.drop_piece(game_drop.player1, 3)
      end

      it 'drops a piece down a half filled column' do
        expect(game_drop.drop_piece(game_drop.player2, 3)).to eq([2, 2])
      end
    end

    context 'when a player tries to drop in a full column once and lets player try again' do
      before do
        game_drop.drop_piece(game_drop.player1, 3)
        game_drop.drop_piece(game_drop.player2, 3)
        game_drop.drop_piece(game_drop.player1, 3)
        game_drop.drop_piece(game_drop.player2, 3)
        game_drop.drop_piece(game_drop.player1, 3)
        game_drop.drop_piece(game_drop.player2, 3)
        game_drop.drop_piece(game_drop.player1, 3)
      end
      it 'returns an error message and put piece in another chosen column' do
        expect(game_drop.drop_piece(game_drop.player1, 3)).to eq('Column is full. Try again!')
        expect(game_drop.drop_piece(game_drop.player1, 1)).to eq([5, 0])
      end
    end
  end

  describe '#end_turn' do
    subject(:game_turn) { described_class.new('player A', 'player B')}
    context 'when turn ends' do
      it 'changes current_player to the other player' do
        expect(game_turn.end_turn(game_turn.player1)).to eq(game_turn.player2)
      end
    end
  end

  describe '#check_victory' do
    subject(:game_victory) {described_class.new()}
    context 'when 4 tiles are connected horizontally' do
      before do
        let(:h_board) {[
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ ⚫ ⚫ ⚫ ⚫]
        ]}
      end
      xit 'returns victory for player 1' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(h_board)
      end
    end

    context 'when 4 tiles are connected vertically' do
      before do
        let(:v_board) {[
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ ⚪ _ _ _],
          %w[_ _ _ ⚪ _ _ _],
          %w[_ _ _ ⚪ _ _ _],
          %w[_ _ _ ⚪ ⚫ ⚫ ⚫]
        ]}
      end
      xit 'returns victory for player 2' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(v_board)
      end
    end

    context 'when 4 tiles are connected diagonally' do
      before do
        let(:d_board) {[
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ ⚫ ⚪ ⚪ _ _ _],
          %w[_ ⚪ ⚫ ⚪ _ _ _],
          %w[_ ⚪ ⚪ ⚫ _ _ _],
          %w[_ ⚪ ⚪ ⚪ ⚫ ⚫ ⚫]
        ]}
      end
      xit 'returns victory for player 1' do
        expect(game_victory).to receive(:victory)
        game_victory.check_victory(d_board)
      end
    end

    context 'when there is no winning condition' do
      before do
        let(:incomplete_board) {[
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[⚫ ⚫ ⚪ ⚪ _ _ _],
          %w[⚫ ⚪ ⚪ ⚪ _ _ _],
          %w[⚪ ⚫ ⚫ ⚫ _ _ _],
          %w[⚫ ⚪ ⚪ ⚪ ⚫ ⚫ ⚫]
        ]}
      end
      xit 'returns nil' do
        expect(game_victory.check_victory(incomplete_board)).to be_nil
      end
    end
  end
end
