module StreetFighter
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
end

