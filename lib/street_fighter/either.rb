module StreetFighter
  class Either
    attr_reader :left, :right

    def initialize left_value, right_value
      @left  = Left.new(left_value)
      @right = Right.new(right_value)
    end
  end
end
