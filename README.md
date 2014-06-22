# StreetFighter - better error handling for Ruby

This library helps to avoid the code smell of "cascading conditionals" (otherwise known as the StreetFighter anti-pattern) by using providing an "Either" data type and interface to your program.

![The StreetFighter anti-pattern as seen in PHP](images/streetfighter.jpg)

## Example

Let's pretend that we want to validate a Person record having a name and age field:

```ruby
Person = Struct.new(:name, :age)
```

We want to run a chain of validations, and return a particular message for the first one that failed. We can, of course, do this with a chain of nested conditions as follows:

```ruby
if person.name == 'Bob'
  if person.age >= 21
    person
  else
    "Person is too young!"
  end
else
  "Person is not named Bob!"
end
```

The problem is that this kind of nested conditional logic can be difficult to read. Things quickly deteriorate as we add more checks. I think that we can do better.

```ruby
bob = Person.new("Bob", 15)

include StreetFighter

# We need to ensure that all of our test functions wrap the result in a
# StreetFighter::EitherValue class (which has to be a Left or a Right). We'll write
# a helper function to reduce boilerplate in test definition:
def failable_test person, bool, msg
  bool ? Right.new(person) : Left.new(msg)
end

valid_age  = Proc.new do |p|
               failable_test p, p.age >= 21, "Person is too young!"
            end

valid_name = Proc.new do |p|
               failable_test p, p.name == 'Bob', "Person is not named Bob!"
             end

Right.new(bob).failable(valid_age, valid_name)

=> #<StreetFighter::Left:0x000001017012a8 @value="Person is too young!">
```

## Credits

Thanks to [Paul Dragoonis](https://twitter.com/dr4goonis) for [identifying
this anti-pattern and giving us a great graphical illusttration of the beast in the wild](https://twitter.com/dr4goonis/status/476617165463105536).
