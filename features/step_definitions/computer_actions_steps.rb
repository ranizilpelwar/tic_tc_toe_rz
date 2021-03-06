require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/gameplay/computer_actions.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/gameplay/game_board.rb'
require_relative '../../test/players/mock_player_manager.rb'

Given("a game is being played with a computer player") do
  @player_manager = MockPlayerManager.new
	@computer_player_symbol = @player_manager.player1.symbol
  @best_max_move = -20000
	@best_min_move = 20000
	@depth = 5
end

Given("selecting square 5 can result in a win for the computer player") do
  @new_board = [ "X", "O", "X", "X", "5", "O", "O", "O", "X" ]
  @game_board = TicTacToeRZ::GamePlay::GameBoard.new(@new_board)
	@computer_actions = TicTacToeRZ::GamePlay::ComputerActions.new(@game_board, @player_manager)
end

When("the computer player makes a move") do
  @actual_computer_move = @computer_actions.get_best_move(@new_board, @computer_player_symbol, @depth, @best_max_move, @best_min_move)
end

Then("the computer's next move matches square {int} on the board") do |int|
  index = int - 1 
	expect(@actual_computer_move.index).to eq(index)
end

Given("selecting square {int} is the only spot left") do |int|
	@new_board = [ "X", "O", "X", "X", "5", "O", "O", "X", "X" ]
  @game_board = TicTacToeRZ::GamePlay::GameBoard.new(@new_board)
	@computer_actions = TicTacToeRZ::GamePlay::ComputerActions.new(@game_board, @player_manager)
end

Given("there are multiple moves to make but one square can result in a win") do
  @new_board = [ "X", "O", "X", "X", "5", "O", "O", "O", "X" ]
  @game_board = TicTacToeRZ::GamePlay::GameBoard.new(@new_board)
	@computer_actions = TicTacToeRZ::GamePlay::ComputerActions.new(@game_board, @player_manager)
end

Given(/there are multiple moves to make on the board \[\"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\", \"([0-9A-z])\" \] but one square can result in a (?:win|block)/) do |square1, square2, square3, square4, square5, square6, square7, square8, square9|
  @new_board = [ square1, square2, square3, square4, square5, square6, square7, square8, square9]
  @game_board = TicTacToeRZ::GamePlay::GameBoard.new(@new_board)
	@computer_actions = TicTacToeRZ::GamePlay::ComputerActions.new(@game_board, @player_manager)
end


