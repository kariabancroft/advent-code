require 'pry'

def look_and_say(input)
  value = input
  50.times do
    value = generate_sequence(value)
  end

  return value.length
end

def generate_sequence(input)
  input = input.split("")

  output = ""
  previous_val = ""
  count = 0

  input.each_with_index do |val, i|
    if val == previous_val || previous_val == ""
      count += 1
    else
      output << count.to_s + previous_val
      count = 1
    end
    previous_val = val
  end

  output << count.to_s + previous_val

  return output
end

def convert_to_string(hash)
  str = ""
  hash.each do |k, v|
    str << v.to_s + k
  end
  return str
end


puts look_and_say("1113222113")
# puts look_and_say("111")
