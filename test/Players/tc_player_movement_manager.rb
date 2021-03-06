require 'test/unit'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/nil_reference_error.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/invalid_value_error.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/players/player_type.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/players/player_movement_manager.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/gameplay/match_type.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/gameplay/match_type_manager.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/invalid_value_error.rb'

class TestPlayerMovementManager < Test::Unit::TestCase

  def setup
    @player1_type = TicTacToeRZ::Players::PlayerType.new(:Human)
    @player2_type = TicTacToeRZ::Players::PlayerType.new(:Computer)
    @type_of_match = TicTacToeRZ::GamePlay::MatchType.new(@player1_type, @player2_type)
    @player_movement_manager = TicTacToeRZ::Players::PlayerMovementManager.new(@type_of_match)
  end

  def test_initialize_raises_an_exception_when_type_of_match_is_nil
    type_of_match = nil
    assert_raises(TicTacToeRZ::Exceptions::NilReferenceError) { TicTacToeRZ::Players::PlayerMovementManager.new(type_of_match) }
  end

  def test_initialize_sets_last_move_of_player1_to_negative_one_when_type_of_match_is_given
    assert_equal(-1, @player_movement_manager.player1_last_move, "Initial last move should be -1.")
  end

  def test_initialize_sets_last_move_of_player2_to_negative_one_when_type_of_match_is_given
    assert_equal(-1, @player_movement_manager.player2_last_move, "Initial last move should be -1.")
  end

  def test_initialize_sets_match_type_to_what_is_given
    assert_equal(@type_of_match, @player_movement_manager.match_type, "Match types should be the same")
  end

  def test_get_last_move_for_player_raises_InvalidValueError_when_player_number_is_zero
    assert_raises(TicTacToeRZ::Exceptions::InvalidValueError) { @player_movement_manager.get_last_move_for_player(0) }
  end  

  def test_get_last_move_for_player_raises_InvalidValueError_when_player_number_is_negative
    assert_raises(TicTacToeRZ::Exceptions::InvalidValueError) { @player_movement_manager.get_last_move_for_player(-1) }
  end

  def test_get_last_move_for_player_raises_InvalidValueError_when_player_number_is_three
    assert_raises(TicTacToeRZ::Exceptions::InvalidValueError) { @player_movement_manager.get_last_move_for_player(3) }
  end

  def test_get_last_move_returns_last_move_for_player1_when_player_number_is_one
    player_number = 1
    updated_move = 5
    @player_movement_manager.update_last_move_for_player(player_number, updated_move)
    assert_equal(updated_move, @player_movement_manager.get_last_move_for_player(player_number))
  end

  def test_get_last_move_returns_last_move_for_player2_when_player_number_is_two
    player_number = 2
    updated_move = 5
    @player_movement_manager.update_last_move_for_player(player_number, updated_move)
    assert_equal(updated_move, @player_movement_manager.get_last_move_for_player(player_number))
  end

  def test_last_move_is_updated_when_move_is_zero
    player_number = 1
    move = 0
    @player_movement_manager.update_last_move_for_player(player_number, move)
    assert_equal(move, @player_movement_manager.get_last_move_for_player(player_number))
  end

  def test_last_move_is_updated_when_move_is_the_same_as_the_largest_index
    player_number = 1
    move = TicTacToeRZ::Players::PlayerMovementManager::LARGEST_INDEX
    @player_movement_manager.update_last_move_for_player(player_number, move)
    assert_equal(move, @player_movement_manager.get_last_move_for_player(player_number))
  end

  def test_moves_recordable_returns_true_for_match_type_human_vs_human
    match_type = TicTacToeRZ::GamePlay::MatchTypeManager.new.matches[0]
    player_movement_manager = TicTacToeRZ::Players::PlayerMovementManager.new(match_type)
    assert_true(player_movement_manager.moves_recordable?(1))
  end

  def test_moves_recordable_returns_true_for_match_type_human_vs_computer
    assert_true(@player_movement_manager.moves_recordable?(2))
  end

  def test_moves_recordable_returns_false_for_match_type_computer_vs_computer
    match_type = TicTacToeRZ::GamePlay::MatchTypeManager.new.matches[0]
    player_movement_manager = TicTacToeRZ::Players::PlayerMovementManager.new(match_type)
    assert_false(player_movement_manager.moves_recordable?(3))
  end
end

