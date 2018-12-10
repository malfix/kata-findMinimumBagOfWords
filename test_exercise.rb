require_relative "exercise"
require "test/unit"

class TestExercise < Test::Unit::TestCase
  test 'not found' do
    ex = Exercise.new('01')
    assert_equal nil, ex.find('000000000')
  end

  test 'retry with shortest string ' do
    @ex = Exercise.new('01','010', '01010')
    assert_equal ['01','01','01'], @ex.find('010101')
  end

  test 'match longest in the middle' do
    @ex = Exercise.new('0','1','10')
    assert_equal ['0','10','1'], @ex.find('0101')
  end

  test 'match longest at the end' do
    @ex = Exercise.new('0','1','101')
    assert_equal ['0','101'], @ex.find('0101')
  end

  test 'match longest at the beginning' do
    @ex = Exercise.new('0','1','010')
    assert_equal ['010','1'], @ex.find('0101')
  end
end
