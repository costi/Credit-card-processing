module Luhn
  # Shamelessly stolen from http://rosettacode.org/wiki/Luhn_test_of_credit_card_numbers#Ruby
  # there is no point in reinventing the wheel in production code
  def self.valid?(code)
    s1 = s2 = 0
    code.to_s.reverse.chars.each_slice(2) do |odd, even| 
      s1 += odd.to_i
  
      double = even.to_i * 2
      double -= 9 if double >= 10
      s2 += double
    end
    (s1 + s2) % 10 == 0
  end
end
