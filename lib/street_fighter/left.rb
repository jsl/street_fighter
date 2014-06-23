module StreetFighter
  class Left < EitherValue
    def match other # >> (then)
      EitherCheck.new(other).run!
      self
    end

    def tournament *fns
      self
    end

    def bind func
      self
    end
  end
end

