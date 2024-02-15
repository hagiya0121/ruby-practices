require 'date'

puts Date.today.strftime("%-m月 %Y").center(20)
puts "日 月 火 水 木 金 土"
last_day = Date.new(2024, 2, -1).day
last_day.times { |day| print day + 1 }