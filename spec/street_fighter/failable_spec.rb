require 'spec_helper'

module StreetFighter
  describe "#follows" do
    it "returns the first Left after a sequence of Right values" do
      Left.new("first").follows(Right.new("second")).
        must_equal Left.new("first")
    end

    it "returns a Right if all values in the sequence are Right" do
      Right.new("first").follows(Right.new("second")).
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

    describe "#failable" do
      it "returns the final Right value if sequence only results in Rights" do
        bob = Person.new("Bob", 22)

        valid_age  = method(:old_enough?)
        valid_name = method(:bob?)

        Right.new(bob).failable(valid_age, valid_name).must_equal Right.new(bob)
      end

      it "returns the first Left value if a computation fails in the sequence" do
        young_bob = Person.new("Bob", 15)

        valid_age  = method(:old_enough?)
        valid_name = method(:bob?)

        Right.new(young_bob).failable(valid_age, valid_name).
          must_equal Left.new("Person is not old enough!")
      end

      it "raises an ArgumentError if the function doesn't return an EitherValue" do
        bob = Person.new("Bob", 22)

        proc { Right.new(bob).failable(Proc.new{ Object.new }) }.
          must_raise ArgumentError
      end

      it "passes any mutations to the object to subsequent functions" do
        young_bob = Person.new("Bob", 15)

        add_to_age  = Proc.new{|p| p.age += 1 ; Right.new(p) }

        res = Right.new(young_bob).failable(add_to_age)
        res.value.age.must_equal 16
      end
    end
  end

end


