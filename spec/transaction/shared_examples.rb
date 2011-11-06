require 'spec_helper'

shared_examples 'a transaction' do
  let(:transaction){described_class.new}
  it 'has an amount' do
    transaction.amount = 200
    transaction.amount.should == 200
  end
end
