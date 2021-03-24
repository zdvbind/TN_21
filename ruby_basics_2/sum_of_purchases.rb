purchases = {}
total_sum = 0
loop do
  puts "Введите название товара или слово \"стоп\""
  title = gets.chomp
  break if title == 'стоп'

  if purchases[title].nil?
    puts 'Введите цену за единиц товара'
    price = gets.chomp.to_f
    puts 'Введите количество товара'
    quantity = gets.chomp.to_f
    purchases[title] = { price: price, quantity: quantity }
  else
    puts 'Товар с таким названием уже существует, цена известна, введите количество'
    quantity = gets.chomp.to_f
    purchases[title][:quantity] += quantity
  end
end
purchases.each_value do |v|
  v[:sum] = v[:price] * v[:quantity]
  total_sum += v[:sum]
end
puts purchases
puts "Общий чек составил #{total_sum}"
