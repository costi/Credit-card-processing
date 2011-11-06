require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'credit_card')
describe CreditCard do
  let(:cc) {CreditCard.new}
  it 'has a number' do
    cc.number = '4111111111111111'
    cc.number.should == '4111111111111111'
  end
end
