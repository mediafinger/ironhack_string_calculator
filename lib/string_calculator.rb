class StringCalculator
  def self.add(string)
    numbers = string.split(",")
    numbers.reduce(0) { |sum, number| sum + number.to_i }
  end
end
