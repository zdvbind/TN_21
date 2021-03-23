fib_arr = [0, 1]
while (fib = fib_arr[-1] + fib_arr[-2]) < 100
  fib_arr << fib
end
puts fib_arr
