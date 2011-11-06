require File.join(File.dirname(__FILE__), 'environment')
class Transaction
  include DataMapper::Resource
  property :id,         Serial
  property :amount,     Decimal
end
