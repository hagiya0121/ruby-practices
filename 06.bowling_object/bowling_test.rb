# frozen_string_literal: true

require 'test/unit'
require_relative 'shot'
require_relative 'frame'
require_relative 'game'

class TestBowling < Test::Unit::TestCase
  test 'Shot#socre' do
    assert_equal 10, Shot.new('X').score
    assert_equal 1, Shot.new('1').score
  end

  test 'Frame#score' do
    assert_equal 10, Frame.new('X').score
    assert_equal 10, Frame.new('7', '3').score
    assert_equal 30, Frame.new('X', 'X', 'X').score
  end

  test 'Frame#strike?' do
    assert_equal true, Frame.new('X').strike?
    assert_equal false, Frame.new('7', '3').strike?
  end

  test 'Frame#spare?' do
    assert_equal true, Frame.new('7', '3').spare?
    assert_equal false, Frame.new('X').spare?
  end
end
