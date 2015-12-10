require 'test_helper'

class CircleTimeTest < Minitest::Test

  def setup
    DateTime.stubs(:now).returns(DateTime.parse("Fri, 11 Dec 2015 02:20:15 +0900"))
  end

  def test_that_it_has_a_version_number
    refute_nil ::Circletime::VERSION
  end

  def test_it_today_build_time
    body = [
      {start_time:"2015-12-10T10:00:00.000Z", "build_time_millis":1},
      {start_time:"2015-12-11T10:00:00.000Z", "build_time_millis":2},
      {start_time:"2015-12-12T10:00:00.000Z", "build_time_millis":3}
    ]
    res_stub(body)
    build_t = CircleTime::BuildTime.new("org")
    assert_equal 2, build_t.today
  end

  def test_it_yestaday_build_time
    body = [
      {start_time:"2015-12-10T10:29:59.587Z", "build_time_millis":1},
      {start_time:"2015-12-11T10:29:59.587Z", "build_time_millis":2},
      {start_time:"2015-12-12T10:29:59.587Z", "build_time_millis":3}
    ]
    res_stub(body)
    build_t = CircleTime::BuildTime.new("org")
    assert_equal 1, build_t.yestaday
  end

  def test_it_week_build_time
    body = [
      {start_time:"2015-12-06T10:29:59.587Z", "build_time_millis":99},
      {start_time:"2015-12-07T10:29:59.587Z", "build_time_millis":1},
      {start_time:"2015-12-09T10:29:59.587Z", "build_time_millis":2},
      {start_time:"2015-12-13T10:29:59.587Z", "build_time_millis":3},
      {start_time:"2015-12-14T10:29:59.587Z", "build_time_millis":99}
    ]
    res_stub(body)
    build_t = CircleTime::BuildTime.new("org")
    assert_equal 6, build_t.week
  end

  def test_it_month_build_time
    body = [
      {start_time:"2015-11-30T10:29:59.587Z", "build_time_millis":99},
      {start_time:"2015-12-01T10:29:59.587Z", "build_time_millis":1},
      {start_time:"2015-12-09T10:29:59.587Z", "build_time_millis":2},
      {start_time:"2015-12-31T10:29:59.587Z", "build_time_millis":3},
      {start_time:"2015-01-01T10:29:59.587Z", "build_time_millis":99}
    ]
    res_stub(body)
    build_t = CircleTime::BuildTime.new("org")
    assert_equal 6, build_t.month
  end

  private
 
  def res_stub(body)
    res = OpenStruct.new
    res.body = body
    CircleCi.stubs(:organization).returns(res)
  end
  
end
