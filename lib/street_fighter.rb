require 'street_fighter/version'

require 'street_fighter/either_value'
require 'street_fighter/right'
require 'street_fighter/left'
require 'street_fighter/either'
require 'street_fighter/either_check'

module StreetFighter
  def self.play(hero, *opponents)
    Right.new(hero).play(*opponents)
  end
end
