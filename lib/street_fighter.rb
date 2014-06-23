require 'street_fighter/version'

require 'street_fighter/either_value'
require 'street_fighter/right'
require 'street_fighter/left'
require 'street_fighter/either'
require 'street_fighter/either_check'

module StreetFighter
  def self.tournament(hero, *opponents)
    Right.new(hero).tournament(*opponents)
  end
end
