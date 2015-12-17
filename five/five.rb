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
  three = three_vowels?(word)
  dupe = dupe_letter?(word)
  bad = bad_combo?(word)
  # puts "#{word}: 3: #{three}, dupe: #{dupe}, bad: #{bad}"
  if three && dupe && !bad
    return true
  else
    return false
  end
end

def three_vowels?(word)
  vowels = "aeiou".split("")
  letters = word.split("")
  valid = false

  count = 0
  i = 0
  while (count < 3 && i < letters.count) do
    count += 1 if vowels.include?(letters[i])
    i += 1
  end

  valid = true if count >= 3

  return valid
end

def dupe_letter?(word)
  has_dupe = false
  letters = word.split("")
  letters.each_with_index do |let, index|
    if let == letters[index + 1]
      has_dupe = true
    end
  end
  has_dupe
end

def bad_combo?(word)
  is_bad = false
  bad_strings = ["ab", "cd", "pq", "xy"]

  bad_strings.each do |bad_substr|
    if word.include?(bad_substr)
      is_bad = true
      # puts "BAD: #{word} and #{bad_substr}"
    end
  end
  is_bad
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
