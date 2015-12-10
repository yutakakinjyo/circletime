require 'test_helper'

class CircleTimeTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Circletime::VERSION
  end

  def test_it_week_build_timen
    DateTime.stubs(:now).returns(DateTime.parse("Fri, 11 Dec 2015 02:20:15 +0900"))
    res = OpenStruct.new
    res.body = [{start_time:"2014-04-12T10:29:59.587Z", "build_time_millis":16308}]
    CircleCi.stubs(:organization).returns(res)
    build_t = CircleTime::BuildTime.new("yutakakinjyo")
    p build_t.week
  end
  
end
