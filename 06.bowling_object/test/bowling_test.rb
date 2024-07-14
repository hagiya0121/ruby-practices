# frozen_string_literal: true

require 'test/unit'
require_relative '../shot'
require_relative '../frame'
require_relative '../game'

class TestBowling < Test::Unit::TestCase
  test 'Shot#socre' do
    assert_equal 10, Shot.new('X').score
    assert_equal 1, Shot.new('1').score
  end

  test 'Shot#strike?' do
    assert Shot.new('X').strike?
    assert !Shot.new('1').strike?
  end

  test 'Frame#score' do
    frames = []
    shots = ['7', '3', 'X', 'X', 'X', 'X'].map { |m| Shot.new(m) }
    frames << Frame.new(0, shots[0..1])
    frames << Frame.new(1, shots[2..2])
    frames << Frame.new(9, shots[3..5])
    assert_equal 20, frames[0].score(frames)
    assert_equal 30, frames[1].score(frames)
    assert_equal 30, frames[2].score(frames)
  end

  test 'Frame#last?' do
    assert Frame.new(9, []).last?
    assert !Frame.new(0, []).last?
  end

  test 'Game#score' do
    assert_equal 139, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').score
    assert_equal 164, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X').score
    assert_equal 107, Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4').score
    assert_equal 134, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0').score
    assert_equal 144, Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8').score
    assert_equal 300, Game.new('X,X,X,X,X,X,X,X,X,X,X,X').score
    assert_equal 292, Game.new('X,X,X,X,X,X,X,X,X,X,X,2').score
    assert_equal 50, Game.new('X,0,0,X,0,0,X,0,0,X,0,0,X,0,0').score
  end
end
