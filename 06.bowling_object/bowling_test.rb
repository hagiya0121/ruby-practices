# frozen_string_literal: true

require 'test/unit'
require_relative 'shot'
require_relative 'frame'

class TestBowling < Test::Unit::TestCase
  test 'Shot#socre' do
    shot1 = Shot.new('X')
    shot2 = Shot.new('1')
    assert_equal 10, shot1.score
    assert_equal 1, shot2.score
  end

  test 'Frame#score' do
    frame1 = Frame.new('6', '3')
    frame2 = Frame.new('X')
    frame3 = Frame.new('7', '3')
    frame4 = Frame.new('X', 'X', 'X')
    assert_equal 9, frame1.score
    assert_equal 'strike', frame2.score
    assert_equal 'spare', frame3.score
    assert_equal 30, frame4.score
  end
end
