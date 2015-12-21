require 'pry'

def count_characters(filename)
  file_data, all_count = read_file(filename)
  other_count = inner_count(file_data)

  return all_count - other_count
end

def inner_count(file_data)
  count = 0
  file_data.each do |row|
    string = eval(row)
    count += string.length
    # binding.pry
  end
  return count
end

def read_file(filename)
  file = []
  count = 0
  File.open(filename, "r") do |f|
    f.each_line do |line|
      file << line.chomp
      count += line.chomp.length
    end
  end
  return file, count
end

#puts count_characters("input-short.txt")
puts count_characters("input.txt")
