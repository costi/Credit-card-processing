require File.join(File.dirname(__FILE__), 'environment')

class Batch

  def initialize(file_handle)
    @credit_cards = []
    @file_handle = file_handle
  end

  attr_reader :credit_cards

  # Add Tom 4111111111111111 $1000
  def parse_credit_card_line(line)
    if matchdata = line.match(/^Add (\w+) (\d{1,19}) \$(\d+)$/)
      {:person => matchdata[1], :number => matchdata[2], :credit_limit => matchdata[3]}
    end
  end

  # Charge Tom $500
  def parse_charge_line(line)
    if matchdata = line.match(/^Charge (\w+) \$(\d+)$/)
      {:person => matchdata[1], :amount => matchdata[2].to_i}
    end
  end

  # Credit Lisa $100
  def parse_credit_line(line)
    if matchdata = line.match(/^Credit (\w+) \$(\d+)$/)
      {:person => matchdata[1], :amount => matchdata[2].to_i}
    end
  end

  # dispatcher method.
  # the question arises - should I use the regex that I use to parse also for dispatch?
  # if the lines are easy to identify, then I say keep it like that
  # TODO: have parser classes if the lines in production get too complicated
  def process_line(line)
    line = line.chomp
    if line.match(/^Add /)
      @credit_cards << CreditCard.create(parse_credit_card_line(line))
    elsif line.match(/^Charge /)
      charge = parse_charge_line(line)
      if cc = CreditCard.first(:person => charge[:person])
        cc.charge(charge[:amount])
      end
    elsif line.match(/^Credit /)
      credit = parse_credit_line(line)
      if cc = CreditCard.first(:person => credit[:person])
        cc.credit(credit[:amount])
      end
    end
  end

  def process_file
    @file_handle.each_line do |line|
      process_line(line)
    end
  end

  def summary
    credit_cards.map{|cc| [cc.person, cc.luhn_valid? ? cc.balance.to_s : 'error']}
  end


end
