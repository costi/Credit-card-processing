require File.join(File.dirname(__FILE__), '..', 'environment')
module Transactions
  class Charge < Transaction
    validates_within :amount, :set => (0..Infinity)
  end
end
