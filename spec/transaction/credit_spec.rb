require 'spec_helper'
require File.join(Root, 'transaction')
require File.join(Root, 'transaction/credit')
require 'transaction/shared_examples'
module Transactions
  describe Credit do
    it_behaves_like "a transaction"
    let(:credit){described_class.new}

    it 'stores the amount as negative if we pass in a positive amount' do
      credit = Credit.new(:amount => 300)
      credit.amount.to_i.should == -300
    end

    it 'is not valid if amount is positive' do
      credit.stub(:amount).and_return(100)
      credit.valid?
      credit.errors[:amount].should include('Amount must be less than or equal to 0')
    end
  end
end
