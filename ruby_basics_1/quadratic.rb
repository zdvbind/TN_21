puts 'Дано квадратное уровнение вида ax^2+bx+c.'
puts 'Введите a'
a = gets.chomp.to_f
puts 'Введите b'
b = gets.chomp.to_f
puts 'Введите c'
c = gets.chomp.to_f

# Find quadratic discriminant
d = b**2 - 4 * a * c
if d.negative?
  puts "D = #{d}, корней нет"
elsif d.zero?
  puts "D = #{d}, корень уравнения: #{-b / (2 * a)}"
else
  puts "D = #{d}, корни уравнения: #{(-b + Math.sqrt(d)) / (2 * a)}, #{(-b - Math.sqrt(d)) / (2 * a)}"
end
