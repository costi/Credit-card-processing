require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'luhn')

class CreditCard
  include DataMapper::Resource
  property :id,          Serial
  property :number,      String, :required => true
  property :person,      String, :required => true
  #I could move person to another class, but it's not needed for the current requirements.
  #I would use a person object if a person could have multiple credit cards.
  #Then, the current transaction spec "Charge Tom $500" will have to 
  #specify a card or we can have a default card if we don't specify the card to charge.

  property :credit_limit,       Decimal, :required => true 
  # floats give surprising results when using them as money 
  # so it's always better to use decimal or money
  
  
  validates_with_method :number, :method => :luhn_valid?

  #luhn_valid? method should be extracted in a module that can be used for other models 
  #that need luhn checksums, like Canadian SIN if needed.  
  #also, this will keep credit_card.rb small and focused on data persistence
  def luhn_valid?
    Luhn.valid?(number) ? true : [false, 'needs to be luhn10 valid']
  end

  def balance
    0
  end
end
