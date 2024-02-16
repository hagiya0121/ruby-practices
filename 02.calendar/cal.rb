require 'date'

week_day = Date.new(2024, 2, 1).wday
last_day = Date.new(2024, 2, -1).day
first_weekday_offset = week_day * 3

puts Date.today.strftime("%-m月 %Y").center(20)
puts "日 月 火 水 木 金 土"
print "\s" * first_weekday_offset
(1..last_day).each do |day|
  print "#{day}".rjust(2) + "\s"
  puts "\n" if week_day == 6
  week_day == 6 ? week_day = 0 : week_day += 1
end