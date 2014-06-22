module Failable
  class Right < EitherValue
    def follows other
      EitherCheck.new(other).run!
      other
    end

    def failable *fns
      return self if fns.empty?

      bind(fns.first).tap do |result|
        EitherCheck.new(result).run!
      end.failable(*fns[1..-1])
    end

    def bind func
      func.call(value)
    end
  end
end
