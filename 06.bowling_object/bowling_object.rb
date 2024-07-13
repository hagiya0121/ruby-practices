# frozen_string_literal: true

require_relative 'game'
require_relative 'frame'
require_relative 'shot'

marks = ARGV[0]
game = Game.new(marks)
puts game.score
