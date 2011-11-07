require 'spec_helper'

shared_examples 'a transaction' do
  let(:transaction){described_class.new}
  let(:cc){double 'Credit Card', :id => 1}
  it 'has an amount' do
    transaction.amount = 200
    transaction.amount.abs.should == 200 #credits are negative, charges are positive
  end

  it 'belongs to a credit card' do
    transaction.credit_card = cc
  end

  it 'requires a credit card' do
    if transaction.class == Transactions::Transaction
      # Datamapper bug https://github.com/datamapper/dm-validations/issues/16#issuecomment-2648857
      transaction.valid?
      transaction.errors[:credit_card_id].should include('Credit card must not be blank')
    end
  end

  it 'requires a credit card - workaround for validations bug with saving' do
    unless transaction.class == Transactions::Transaction
      transaction.amount = 100
      transaction.save.should be_false # I should not be able to save it
      transaction.valid?.should be_true # even if the validations are fine
      transaction.errors.size.should == 0
    end
  end
end
