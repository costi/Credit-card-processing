require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'luhn')

class CreditCard
  include DataMapper::Resource
  property :id,          Serial
  property :number,      String
  
  validates_with_method :number, :method => :luhn_valid?

  #luhn_valid? method should be extracted in a module that can be used for other models 
  #that need luhn checksums, like Canadian SIN if needed.  
  #also, this will keep credit_card.rb small and focused on data persistence
  def luhn_valid?
    Luhn.valid?(number) ? true : [false, 'needs to be luhn10 valid']
  end
end
