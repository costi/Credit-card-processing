require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'credit_card')
describe CreditCard do
  let(:cc) {CreditCard.new}
  it 'has a person' do
    cc.person = "Tom"
    cc.person.should == "Tom"
  end

  it 'requires a person' do
    cc.valid?
    cc.errors[:person].should include('Person must not be blank')
  end

  it 'has a number' do
    cc.number = '4111111111111111'
    cc.number.should == '4111111111111111'
  end

  it 'has a credit limit' do
    cc.credit_limit = 2000
    cc.credit_limit.should == 2000
  end

  it 'requires a credit limit' do
    cc.valid?
    cc.errors[:credit_limit].should include('Credit limit must not be blank')
  end

  describe 'with valid attributes' do

    let(:cc){CreditCard.new(:number => '4111111111111111', :person => 'Tom', :credit_limit => 2000)}

    it 'has a starting balance of zero' do
      cc.balance.should == 0
    end
  end


  describe 'number' do
    it 'is required' do
      cc.valid?
      cc.errors[:number].should include('Number must not be blank')
    end

    it 'fails the luhn test for 49927398717 (from rosettacode)' do
      cc.number = '49927398717'
      cc.valid?
      cc.errors[:number].should include('needs to be luhn10 valid')
    end

    it 'fails the luhn test for 1234567812345678 (from rosettacode)' do
      cc.number = '1234567812345678'
      cc.valid?
      cc.errors[:number].should include('needs to be luhn10 valid')
    end

    it 'fails the luhn test for quincy (1234567890123456)' do
      cc.number = '1234567890123456'
      cc.valid?
      cc.errors[:number].should include('needs to be luhn10 valid')
    end

    it 'passes the luhn test for tom (4111111111111111) and lisa (5454545454545454)' do
      ['5454545454545454', '4111111111111111'].each do |number|
        cc.number = number
        cc.valid?
        cc.errors[:number].should_not include('needs to be luhn10 valid')
      end
    end

    it 'passes luhn test for 49927398716 (from rosettacode)' do
      cc.number = '49927398716'
      cc.valid?
      cc.errors[:number].should_not include('needs to be luhn10 valid')
    end

    it 'passes luhn test for 1234567812345670' do
      cc.number = '1234567812345670'
      cc.valid?
      cc.errors[:number].should_not include('needs to be luhn10 valid')
    end
  end
end
