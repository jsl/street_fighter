require 'spec_helper'

describe StreetFighter do
  it "returns the final Right value if sequence only results in Rights" do
    fight1 = Proc.new{|_| Right.new("hey") }
    fight2 = Proc.new{|_| Right.new("hey") }

    StreetFighter.play(Object.new, fight1, fight2).
      must_equal Right.new("hey")
  end

  it "returns the first Left value if a computation fails in the sequence" do
    fight1 = Proc.new{|_| Right.new("hey") }
    fight2 = Proc.new{|_| Left.new("fail!") }

    StreetFighter.play(Object.new, fight1, fight2).must_equal Left.new("fail!")
  end

  it "raises an ArgumentError if the function doesn't return an EitherValue" do
    proc { StreetFighter.play(Object.new, Proc.new{ Object.new }) }.
      must_raise ArgumentError
  end
end
