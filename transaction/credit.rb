require File.join(File.dirname(__FILE__), '..', 'environment')
module Transactions
  class Credit < Transaction
    validates_within :amount, :set => (-Infinity..0)

    # I want to enable calls like Credit.new(:amount => 300)
    # and I want to store credits as negative because I want to sum all transactions up easily
    # from sql also or from Transaction parent class
    def amount=(new_amount) 
      new_amount > 0 ? super(-new_amount) : super(new_amount)
    end
  end
end
