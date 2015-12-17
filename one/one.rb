require 'pry'

def apt_floor(filename)
  file_data = read_file(filename)
  # binding.pry
  floor_count = 0
  file_data.each do |row| # Just in case
    row.split("").each do |character| # Go through each character
      if character == "("
        floor_count += 1
      elsif character == ")"
        floor_count -= 1
      end
    end
  end
  return floor_count
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
