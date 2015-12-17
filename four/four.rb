require "Digest"

def lowest_number(input)
  test_value = 1
  hash_value = Digest::MD5.hexdigest(input + test_value.to_s)

  while !success?(hash_value)
    test_value += 1
    hash_value = Digest::MD5.hexdigest(input + test_value.to_s)
  end

  return test_value
end

def success?(value)
  if value.start_with?("00000")
    return true
  else
    return false
  end
end

puts lowest_number("bgvyzdsv")
