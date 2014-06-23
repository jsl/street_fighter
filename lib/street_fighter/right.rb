module StreetFighter
  class Right < EitherValue
    def follows other
      EitherCheck.new(other).run!
      other
    end

    def play *fns
      return self if fns.empty?

      bind(fns.first).tap do |result|
        EitherCheck.new(result).run!
      end.play(*fns[1..-1])
    end

    def bind func
      func.call(value)
    end
  end
end
