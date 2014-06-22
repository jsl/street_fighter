module Failable
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
end
