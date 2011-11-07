require File.join(File.dirname(__FILE__), 'environment')
module Transactions  # I want all my payment transaction logic in one namespace
  class Transaction
    include DataMapper::Resource
    property :id,         Serial
    property :amount,     Decimal
    property :type,       Discriminator
    belongs_to :credit_card # defaults to :required => true
  end
end
