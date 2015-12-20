require 'pry'

def nice_count(filename)
  word_data = read_file(filename)

  total_nice = 0

  word_data.each do |word|
    if nice?(word)
      # puts "#{word}: nice"
      total_nice += 1
    else
      # puts "#{word}: naughty"
    end
  end

  return total_nice
end

def nice?(word)
  pairs = two_pairs?(word)
  repeat = repeated_letter?(word)
  # puts "#{word}: pair #{pairs} repeat #{repeat}"
  if pairs && repeat
    return true
  else
    return false
  end
end

def two_pairs?(word)
  valid = false

  letters = word.split("")
  letters.each_with_index do |let, index|
    break if index + 1 >= letters.length
    test_set = let + letters[index + 1]

    if word.length > index + 4
      test_word = word[(index + 2)..word.length]
      return true if test_word.include?(test_set)
    end
  end

  return valid
end

def repeated_letter?(word)
  valid = false

  letters = word.split("")
  letters.each_with_index do |let, index|
    break if letters.length <= index + 2
    if let == letters[index + 2]
      return true
    end
  end

  return valid
end

def read_file(filename)
  file = []
  File.open(filename, "r") do |f|
    f.each_line do |line|
      file << line
    end
  end
  return file
end

 # puts nice_count("input-short.txt")
puts nice_count("input.txt")
