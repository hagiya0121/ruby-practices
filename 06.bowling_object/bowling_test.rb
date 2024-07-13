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
    frames = []
    frames << Frame.new('7', '3', frame_number: 0)
    frames << Frame.new('X', frame_number: 1)
    frames << Frame.new('X', 'X', 'X', frame_number: 2)
    assert_equal 20, frames[0].score(frames)
    assert_equal 30, frames[1].score(frames)
    assert_equal 30, frames[2].score(frames)
  end

  test 'Frame#strike?' do
    assert_equal true, Frame.new('X').strike?
    assert_equal false, Frame.new('7', '3').strike?
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
