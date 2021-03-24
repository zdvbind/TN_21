puts 'Введите день (число)'
day = gets.chomp.to_i
puts 'Введите месяц (число)'
month = gets.chomp.to_i
puts 'Введите год (число)'
year = gets.chomp.to_i

# Create an array with the number of days in each of the months of the year
days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# If the year is a leap year, than February has 29 days
days_in_month[1] = 29 if ((year % 4).zero? && !(year % 100).zero?) || (year % 400).zero?
puts "Это #{days_in_month[0...month - 1].sum + day}-й день в году"
