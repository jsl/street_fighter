module StreetFighter
  class EitherCheck < Struct.new(:klass)
    def run! ; raise ArgumentError unless klass.is_a?(EitherValue) ; end
  end
end

