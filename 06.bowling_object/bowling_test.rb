# frozen_string_literal: true

require 'test/unit'
require_relative 'shot'

class TestBowling < Test::Unit::TestCase
  test 'Shot#socre' do
    shot_1 = Shot.new('X')
    shot_2 = Shot.new('1')
    assert_equal 10, shot_1.score
    assert_equal 1, shot_2.score
  end
end
