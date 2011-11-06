require File.join(File.dirname(__FILE__), 'environment')
class CreditCard
  include DataMapper::Resource
  property :id,          Serial
  property :number,      String
end
