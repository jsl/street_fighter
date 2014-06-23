module StreetFighter
  class Right < EitherValue
    def match other
      EitherCheck.new(other).run!
      other
    end

    def tournament *fns
      return self if fns.empty?

      bind(fns.first).tap do |result|
        EitherCheck.new(result).run!
      end.tournament(*fns[1..-1])
    end

    def bind func
      func.call(value)
    end
  end
end
