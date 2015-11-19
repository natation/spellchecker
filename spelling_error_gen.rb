DICTIONARY = "dictionary.txt"

def transform_word(word)
  todo = rand(4)
  new_word = ""
  case todo
  when 0 # capitalize letters
    word = word.upcase
  when 1 # insert doubles of each letter
    (word.length - 1).times do |i|
      if i == 2 || i == 4
        new_word << word[i] + word[i]
      end
    end
    word = new_word
  when 2 # misspell letters
    (word.length - 1).times do |i|
      if i == 1 || i == 3
        new_word << ('a'..'z').to_a.sample
      else
        new_word << word[i]
      end
    end
    word = new_word
  when 3 # all of the above
    word = word.upcase
    (word.length - 1).times do |i|
      if i == 1 || i == 3
        new_word << word[i]
        new_word << ('a'..'z').to_a.sample
      else
        new_word << word[i]
      end
    end
    word = new_word
  end
  word
end

dictionary = File.readlines(DICTIONARY)
num_words = 5
words = []
num_words.times do |i|
  words << dictionary[rand(1000)]
end

transformed_words = []
words.each do |word|
  transformed_words << transform_word(word.chomp)
end

puts transformed_words
