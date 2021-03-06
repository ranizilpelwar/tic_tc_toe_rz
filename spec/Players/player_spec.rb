require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/players/player.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/players/player_type.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/validators/player_symbol_validator.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/nil_reference_error.rb'
require_relative '../../lib/tic_tac_toe_rz/tictactoeruby.core/exceptions/invalid_value_error.rb'

RSpec.describe "a player" do

	it "has a symbol" do
		expect(player(:Human, "X").symbol).to eq("X") 
	end

  describe "symbol" do
    it "is one character long" do
      expect(symbol_valid?("a")).to be true
    end

    it "cannot be more than one character" do
      expect(symbol_valid?("ab")).to be false
    end
    
    it "can be an alpha character" do
      expect(symbol_valid?("a")).to be true
    end

    it "can be a keyboard symbol" do
      expect(symbol_valid?("$")).to be true
    end

    it "cannot be a number" do
      expect(symbol_valid?("1")).to be false
    end

    it "cannot be a space character" do
      expect(symbol_valid?(" ")).to be false
    end

    it "cannot be an empty character" do
      expect{symbol_valid?("")}.to raise_error(TicTacToeRZ::Exceptions::InvalidValueError)
    end
  end

	it "has a type" do
		expect(player(:Human, "X").type).to eq(:Human)
	end

	describe "type" do
	  it "can be a computer" do
	    expect(player_type(:Computer).selected_option).to eq(:Computer) 
	  end

	  it "can be a human" do
	    expect(player_type(:Human).selected_option).to eq(:Human)
	  end

    it "cannot be a robot" do
      expect(TicTacToeRZ::Players::PlayerType.valid?(:Robot)).to be false
    end
  end

  describe "two players" do
    context "with the same type and symbol" do
      it "are equal" do
        expect(player(:Human, "X").equals?(player(:Human, "X"))).to be true
      end
    end

    context "with the same type and a different symbol" do
      it "are not equal" do
        expect(player(:Human, "X").equals?(player(:Human, "Y"))).to be false
      end
    end

    context "with a different type and same symbol" do
      it "are not equal" do
        expect(player(:Human, "X").equals?(player(:Computer, "X"))).to be false
      end
    end

    context "with a different type and different symbol" do
      it "are not equal" do
        expect(player(:Human, "X").equals?(player(:Computer, "Y"))).to be false
      end
    end
  end

  describe "intialization" do
    it "raises an InvalidValueError when an invalid symbol is passed in" do
      expect{ TicTacToeRZ::Players::Player.new(:Human, " ") }.to raise_error(TicTacToeRZ::Exceptions::InvalidValueError)
    end

    it "raises a NilReferenceError when type is nil" do
      expect{ TicTacToeRZ::Players::Player.new(nil, " ") }.to raise_error(TicTacToeRZ::Exceptions::NilReferenceError)
    end
  end

# Automation Logic
  
  def player(type, symbol)
    TicTacToeRZ::Players::Player.new(type, symbol)
  end

  def symbol_valid?(symbol)
    TicTacToeRZ::Validators::PlayerSymbolValidator.valid?(symbol)
  end

  def player_type(type)
    TicTacToeRZ::Players::PlayerType.new(type)
  end
end



