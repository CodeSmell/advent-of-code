require_relative "../../lib/util/Location.rb"
require "test/unit"

class Test_Location < Test::Unit::TestCase
  
  def test_taxiCabDistance
    loc = Location.new(3,4)
    distance = Location.new(1,1).taxiCabDistance(loc)
    
    assert_equal(5, distance)
  end
  
  def test_convert_string
    locString = Location.new(3,4).asString
    locFromString = Location.convertStringToLocation(locString)
    
    assert_equal("3,4", locString)
    assert_equal(3, locFromString.x)
    assert_equal(4, locFromString.y)
  end

end