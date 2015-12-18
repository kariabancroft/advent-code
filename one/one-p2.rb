require 'pry'

def apt_floor(filename)
  file_data = read_file(filename)
  # binding.pry
  floor_count = 0
  basement_pos = 0
  file_data.each do |row| # Just in case
    row.split("").each_with_index do |character, index| # Go through each character
      if character == "("
        floor_count += 1
      elsif character == ")"
        floor_count -= 1
      end

      if floor_count == -1 && basement_pos == 0
        basement_pos = index + 1
      end
    end
  end
  return floor_count, basement_pos
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

puts apt_floor("input.txt")
