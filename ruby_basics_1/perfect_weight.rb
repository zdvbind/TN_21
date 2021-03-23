puts 'Введите ваше имя'
name = gets.chomp
puts 'Введите Ваш рост'
hight = gets.chomp
perf_weight = (1.15 * (hight.to_i - 110)).to_i
puts perf_weight.negative? ? "#{name}, Ваш вес уже оптимальный" : "#{name}, Ваш оптимальный вес = #{perf_weight} кг."
