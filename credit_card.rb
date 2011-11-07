require File.join(File.dirname(__FILE__), 'environment')
require File.join(File.dirname(__FILE__), 'luhn')

class CreditCard
  include DataMapper::Resource
  property :id,          Serial
  property :number,      String, :required => true
  property :person,      String, :required => true
  has n, :transactions, 'Transactions::Transaction'
  has n, :charges, 'Transactions::Charge'
  has n, :credits, 'Transactions::Credit'
  #I could move person to another class, but it's not needed for the current requirements.
  #I would use a person object if a person could have multiple credit cards.
  #Then, the current transaction spec "Charge Tom $500" will have to 
  #specify a card or we can have a default card if we don't specify the card to charge.

  # floats give surprising results when using them as money 
  # so it's always better to use decimal or money
  property :credit_limit,       Decimal, :required => true 
  
  
  # we actually want to save luhn invalid cards, I misread the req's at first
  # validates_with_method :number, :method => :luhn_valid_validation

  def luhn_valid_validation
    luhn_valid? ? true : [false, 'needs to be luhn10 valid']
  end

  def luhn_valid?
  #luhn_valid? method is extracted in a module that can be used for other models 
  #that need luhn checksums, like Canadian SIN if needed.  
  #also, this will keep credit_card.rb small and focused on data persistence
    #TODO add caching
    Luhn.valid?(number)
  end

  def balance
    transactions.sum(:amount) || 0
  end

  def charge(amount)
    #charges.create(:amount => amount) - doesn't set the credit_card_id, but new does
    # > cc.charges.new(:amount => 10)
    # => #<Transactions::Charge @id=nil @amount=#<BigDecimal:1833f78,'0.1E2',9(18)> @type=nil @credit_card_id=1>
    # cc.charges.create(:amount => 10)
    # #<Transactions::Charge @id=nil @amount=#<BigDecimal:16f0878,'0.1E2',9(18)> @type=Transactions::Charge @credit_card_id=nil>
    if balance + amount <= credit_limit && luhn_valid?
      #TODO add constraint in the db to fix balance race condition
      #     as we might have another process adding a transaction
      #FIXME add rescue block to catch the db constraint firing and return false in case of that
      c = charges.new(:amount => amount)
      c.save 
      c
    end
  end

  def credit(amount)
    if luhn_valid?
      c = credits.new(:amount => amount)
      c.save
      c
    end
  end


end
