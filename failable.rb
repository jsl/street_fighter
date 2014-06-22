require 'minitest/autorun'

describe "#follows" do
  it "returns the first Left after a sequence of Right values" do
    Left.new("first").follows(Right.new("second")).must_equal Left.new("first")
  end

  it "returns a Right if all values in the sequence are Right" do
    Right.new("first").follows(Right.new("second")).must_equal Right.new("second")
  end
end

describe "binding and mapping over failable tests" do
  Person = Struct.new(:name, :age)

  def bob?(person)
    person.name == 'Bob' ? Right.new(person) :
                           Left.new("The name should have been Bob!")
  end

  def old_enough?(person)
    person.age >= 21 ? Right.new(person) :
                       Left.new("Person is not old enough!")
  end

  describe "#bind" do
    it "returns the Right value if the function is successful" do
      bob = Person.new("Bob", 22)

      bob?(bob).bind(method(:old_enough?)).must_equal(Right.new(bob))
    end

    it "returns the first Left value encountered in a sequence" do
      bob = Person.new("Tom", 22)

      bob?(bob).bind(method(:old_enough?)).
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

      Right.new(young_bob).failable(valid_age, valid_name).must_equal Left.new("Person is not old enough!")
    end

    it "raises an ArgumentError if the function doesn't return an EitherValue" do
      bob = Person.new("Bob", 22)

      proc { Right.new(bob).failable(Proc.new{ Object.new }) }.must_raise ArgumentError
    end
  end
end

class EitherCheck < Struct.new(:klass)
  def run! ; raise ArgumentError unless klass.is_a?(EitherValue) ; end
end

class Either
  attr_reader :left, :right

  def initialize left_value, right_value
    @left  = Left.new(left_value)
    @right = Right.new(right_value)
  end
end

class EitherValue
  attr_reader :value

  def initialize value
    @value = value
  end

  def follows # (>>) in Haskell
    raise NotImplementedError, "Follows not implemented here."
  end

  def bind # (>>=) in Haskell
    raise NotImplementedError, "Bind not implemented here."
  end

  def failable # `fmap` in Haskell, but restricted to EitherValues
    raise NotImplementedError, "Bind not implemented here."
  end

  def ==(other)
    self.value == other.value
  end
end

class Right < EitherValue
  def follows other
    EitherCheck.new(other).run!
    other
  end

  def failable *fns
    return self if fns.empty?

    fns.first.call(self.value).tap do |result|
      EitherCheck.new(result).run!
    end.failable(*fns[1..-1])
  end

  def bind func
    func.call(value)
  end
end

class Left < EitherValue
  def follows other # >> (then)
    EitherCheck.new(other).run!
    self
  end

  def failable *fns
    self
  end

  def bind func
    self
  end
end
