module TicTacToeRZ
  module Evaluators
    module PlayerSymbolEvaluator
      def self.equal?(symbol_one, symbol_two)
        symbol_one = symbol_one.upcase
        symbol_two = symbol_two.upcase
        symbol_one.eql? symbol_two
      end
    end
  end
end