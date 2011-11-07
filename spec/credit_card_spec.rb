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

    it 'can credit 500' do
      cc.save
      cc.credit(500).should be_a(Transactions::Credit)
      cc.credits.first.amount.should == -500
    end

    it 'can charge 500' do
      cc.save
      cc.charge(500).should be_a(Transactions::Charge)
      cc.charges.first.amount.should == 500
    end

    it 'charges 500 and it shows 500 in balance' do
      cc.save
      cc.charge(500)
      cc.balance.should == 500
    end

    it 'charges 500, credits 200 and shows 300 in the balance' do
      cc.save
      cc.charge(500)
      cc.credit(200)
      cc.balance.should == 300
    end

    it 'ignores charges over the credit limit as they were declined' do
      cc.save
      cc.charge(cc.credit_limit + 1).should be_false
    end

    it 'charges up to the credit limit' do
      cc.save
      cc.charge(cc.credit_limit).should be_a(Transactions::Charge)
      cc.balance.should == cc.credit_limit
    end

  end


  it 'ignores charges against Luhn 10 invalid cards' do
    cc.number = '49927398717'
    cc.credit_limit = 2000
    cc.charge(200).should be_false
  end

  it 'ignores credits against Luhn 10 invalid cards' do
    cc.number = '49927398717'
    cc.credit_limit = 2000
    cc.credit(200).should be_false
  end

  describe 'number' do

    it 'fails the luhn test for 49927398717 (from rosettacode)' do
      cc.number = '49927398717'
      cc.luhn_valid?.should == false
    end

    it 'fails the luhn test for 1234567812345678 (from rosettacode)' do
      cc.number = '1234567812345678'
      cc.luhn_valid?.should == false
    end

    it 'fails the luhn test for quincy (1234567890123456)' do
      cc.number = '1234567890123456'
      cc.luhn_valid?.should == false
    end

    it 'passes the luhn test for tom (4111111111111111) and lisa (5454545454545454)' do
      ['5454545454545454', '4111111111111111'].each do |number|
        cc.number = number
        cc.luhn_valid?.should == true
      end
    end

    it 'passes luhn test for 49927398716 (from rosettacode)' do
      cc.number = '49927398716'
      cc.luhn_valid?.should == true
    end

    it 'passes luhn test for 1234567812345670' do
      cc.number = '1234567812345670'
      cc.luhn_valid?.should == true
    end
  end
end
