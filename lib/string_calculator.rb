class StringCalculator
  def self.add(string)
    numbers = string.split(",")
    result = numbers.reduce(0) { |sum, number| sum + number.to_f }
    strip_insignificant_zeros(result)
  end

  def self.strip_insignificant_zeros(number)
    number.to_i == number ? number.to_i : number
  end
  private_class_method :strip_insignificant_zeros
end
