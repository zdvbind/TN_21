alphabet = 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'
vowels = 'АОИЕЁЭЫУЮЯ'
vowels_hash = {}
vowels.each_char do |char|
  vowels_hash[char] = alphabet.index(char) + 1
end
puts vowels_hash
