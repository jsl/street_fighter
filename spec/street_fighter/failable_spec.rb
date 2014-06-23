require 'spec_helper'

module StreetFighter
  describe "#match" do
    it "returns the first Left after a sequence of Right values" do
      Left.new("first").match(Right.new("second")).
        must_equal Left.new("first")
    end

    it "returns a Right if all values in the sequence are Right" do
      Right.new("first").match(Right.new("second")).
        must_equal Right.new("second")
    end
  end

  describe "binding and mapping over failable tests" do

    # The basic data structure we'll be testing is a Person.
    Person = Struct.new(:name, :age)

    # A helper method that returns a value wrapped in an Either based on the
    # boolean test.
    def failable_test person, bool, msg
      bool ? Right.new(person) : Left.new(msg)
    end

    def bob? person
      failable_test person, person.name == 'Bob', 'The name should have been Bob!'
    end

    def old_enough? person
      failable_test person, person.age >= 21, 'Person is not old enough!'
    end

    describe "#bind" do
      it "returns the Right value if the function is successful" do
        bob = Person.new("Bob", 22)
        valid_age  = method(:old_enough?)

        bob?(bob).bind(valid_age).must_equal(Right.new(bob))
      end

      it "returns the first Left value encountered in a sequence" do
        bob = Person.new("Tom", 22)
        valid_age  = method(:old_enough?)

        bob?(bob).bind(valid_age).
          must_equal(Left.new("The name should have been Bob!"))
      end
    end

  end

end


