require 'pry'

def password_generator(input)
  password = input
  # valid?(password)
  while !valid?(password)
    password = generate_password(password)
  end
  return password
end

def generate_password(password)
  letters = password.split("").reverse

  i = 0
  done = false
  while !done
    next_let = next_letter(letters[i])
    if next_let == "{"
      letters[i] = "a"
      i += 1
    else
      letters[i] = next_let
      done = true
    end
  end

  letters.reverse!

  return letters.join
end

def next_letter(current_letter)
  return (current_letter.codepoints.first + 1).chr
end

def valid?(password)
  straight = increasing_straight?(password)
  bad_letters = contains_bad_letters?(password)
  pair = two_pairs?(password)

  puts "PW: #{password}, Straight: #{straight}, Bad: #{bad_letters}, Pair: #{pair}"

  if straight && !bad_letters && pair
    return true
  else
    return false
  end
end

def increasing_straight?(password)
  letters = password.split("")
  i = 0
  while i + 2 < letters.length
    first = letters[i]
    second = next_letter(first)
    third = next_letter(second)

    if (letters[i..i + 2].join) == (first + second + third)
      return true
    end
    i += 1
  end

  return false
end

def contains_bad_letters?(password)
  has_bad = false

  bad_letters = ["i", "o", "l"]
  bad_letters.each do |bad|
    has_bad = true if password.include?(bad)
  end

  return has_bad
end

def two_pairs?(word)
  pair_count = 0
  while pair_count < 2 && word.length != 0
    paired, word = pair_info(word)
    pair_count += 1 if paired
    break if !paired
  end

  return pair_count == 2
end

def pair_info(word)
  valid = false

  i = 0
  while (i + 1 < word.length) && !valid
    if word[i] == word[i + 1]
      # pair found
      valid = true
      word = word[i + 2..word.length - 1]
      word = "" if word.length < 2
    else
      i += 1
    end
  end

  return valid, word
end

# puts password_generator("vzbxkghb")
puts password_generator("vzbxxzaa")
