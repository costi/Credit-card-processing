require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'transaction')
require File.join('transaction', 'shared_examples')
module Transactions

  describe Transaction do
    let(:transaction){Transaction.new}
    it_behaves_like "a transaction"
  end
  
end
