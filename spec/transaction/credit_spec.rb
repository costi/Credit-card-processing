require 'spec_helper'
require File.join(Root, 'transaction')
require File.join(Root, 'transaction/credit')
require 'transaction/shared_examples'
module Transactions
  describe Credit do
    let(:charge){described_class.new}
    it_behaves_like "a transaction"
  end
end
