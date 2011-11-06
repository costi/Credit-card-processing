require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'transaction')
describe Transaction do
  let(:transaction){Transaction.new}
  it 'has an amount' do
    transaction.amount = 200
    transaction.amount.should == 200
  end
  
end
