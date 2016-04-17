require "string_calculator"

describe StringCalculator do
  describe ".add" do
    context "given an empty string" do
      it "returns zero" do
        expect(StringCalculator.add("")).to eql(0)
      end
    end

    context "given a single number" do
      context "'4'" do
        it "returns 4" do
          expect(StringCalculator.add("4")).to eql(4)
        end
      end

      context "'10'" do
        it "returns 10" do
          expect(StringCalculator.add("10")).to eql(10)
        end
      end
    end

    context "given two numbers" do
      context "'2,4'" do
        it "returns 6" do
          expect(StringCalculator.add("2,4")).to eql(6)
        end
      end

      context "'17,100'" do
        it "returns 117" do
          expect(StringCalculator.add("17,100")).to eql(117)
        end
      end
    end

    context "given multiple numbers" do
      context "'2,4,94'" do
        it "returns 100" do
          expect(StringCalculator.add("2,4,94")).to eql(100)
        end
      end

      context "'1,2,3,4,55,35'" do
        it "returns 100" do
          expect(StringCalculator.add("1,2,3,4,55,35")).to eql(100)
        end
      end
    end
  end
end
