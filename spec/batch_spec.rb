require File.join(File.dirname(__FILE__), 'spec_helper')
describe Batch do
  let(:batch){Batch.new}
  let(:credit_card_line){'Add Tom 4111111111111111 $1000'}
  let(:charge_line){'Charge Tom $500'}
  let(:credit_line){'Credit Lisa $100'}

  it 'parses add credit card line' do
    result = batch.parse_credit_card_line( credit_card_line )
    result.should == {:person => 'Tom', :number => '4111111111111111', :amount => '1000'}
  end

  it 'parses charge line' do
    result = batch.parse_charge_line 'Charge Tom $500'
    result.should == {:person => 'Tom', :amount => '500'}
  end

  it 'parses credit line' do
    result = batch.parse_credit_line 'Credit Lisa $100'
    result.should == {:person => 'Lisa', :amount => '100'}
  end

  it 'dispatches add credit card line to the add credit line parser' do
    batch.should_receive(:parse_credit_card_line).with(credit_card_line)
    batch.process_line(credit_card_line)
  end

  it 'dispatches charge line to charge line parser' do
    batch.should_receive(:parse_charge_line).with(charge_line).and_return({:person => 'Tom', :amount => '500'})
    batch.process_line(charge_line)
  end

  it 'dispatches credit line to credit line parser' do
    batch.should_receive(:parse_credit_line).with(credit_line).and_return({:person => 'Lisa', :amount => '100'})
    batch.process_line(credit_line)
  end


  it 'creates a credit card from a credit card line'
  it 'creates a charge from a charge line'
  it 'creates a debit from a debit line'
end
