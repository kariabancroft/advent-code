require 'pry'

def wrap_calculator(filename)
  present_data = read_file(filename)

  total_wrap = 0
  present_data.each do |present|
    dimensions = present.split("x")
    dim_hash = dimensions_to_hash(dimensions)
    total_wrap += present_wrap(dim_hash)
  end

  return total_wrap
end

def dimensions_to_hash(dimension_array)
  dim_hash = {}

  dim_hash[:l] = dimension_array[0].to_i
  dim_hash[:w] = dimension_array[1].to_i
  dim_hash[:h] = dimension_array[2].to_i
  return dim_hash
end

def present_wrap(dimensions)
  wrap = 0

  area_one = dimensions[:l] * dimensions[:w]
  area_two = dimensions[:w] * dimensions[:h]
  area_three = dimensions[:h] * dimensions[:l]

  min_area = [area_one, area_two, area_three].min

  wrap = (2 * area_one) + (2 * area_two) + (2 * area_three) + min_area

  return wrap
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

puts wrap_calculator("input.txt")
# puts wrap_calculator("input_short.txt")
