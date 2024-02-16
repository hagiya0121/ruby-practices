require 'date'

puts Date.today.strftime("%-m月 %Y").center(20)
puts "日 月 火 水 木 金 土"
week_day = Date.new(2024, 2, 1).wday
last_day = Date.new(2024, 2, -1).day
last_day.times do |day|
  print day + 1
  puts "\n" if week_day == 6
  week_day == 6 ? week_day = 0 : week_day += 1
end