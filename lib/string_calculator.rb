class StringCalculator
  def self.add(string)
    numbers = string.split(",")
    numbers[0].to_i + numbers[1].to_i
  end
end
