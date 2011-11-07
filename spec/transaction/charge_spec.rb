require 'spec_helper'
require File.join(Root, 'transaction')
require File.join(Root, 'transaction/charge')
require 'transaction/shared_examples'
module Transactions
  describe Charge do
    let(:charge){Charge.new}
    it_behaves_like "a transaction"

    it 'is not valid if amount is positive' do
      charge.stub(:amount).and_return(-100)
      charge.valid?
      charge.errors[:amount].should include('Amount must be greater than or equal to 0')
    end
  end
end
