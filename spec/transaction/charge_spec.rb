require 'spec_helper'
require File.join(Root, 'transaction')
require File.join(Root, 'transaction/charge')
require 'transaction/shared_examples'
module Transactions
  describe Charge do
    let(:charge){Charge.new}
    it_behaves_like "a transaction"
  end
end
