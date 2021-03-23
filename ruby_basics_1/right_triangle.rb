puts 'Введите длину первой стороны треугольника'
a = gets.chomp.to_f
puts 'Введите длину второй стороны треугольника'
b = gets.chomp.to_f
puts 'Введите длину третьей стороны треугольника'
c = gets.chomp.to_f
if  a == b && a == c
  property = 'равносторонний'
elsif a == b || b == c || a == c
  property = 'равнобедренный'
else
  a, b, c = [a, b, c].sort
  property = if c**2 == a**2 + b**2
               'прямоугольный'
             else
               'не является ни равнобедренным ни прямоугольным ни равносторонним'
             end
end
puts "Заданный треугольник #{property}"
