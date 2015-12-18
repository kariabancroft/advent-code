require 'pry'

def ribbon_calculator(filename)
  present_data = read_file(filename)

  total_ribbon = 0
  present_data.each do |present|
    dimensions = present.split("x")
    dim_hash = dimensions_to_hash(dimensions)
    total_ribbon += present_ribbon(dim_hash)
  end

  return total_ribbon
end

def dimensions_to_hash(dimension_array)
  dim_hash = {}

  dim_hash[:l] = dimension_array[0].to_i
  dim_hash[:w] = dimension_array[1].to_i
  dim_hash[:h] = dimension_array[2].to_i
  return dim_hash
end

def present_ribbon(dimensions)
  ribbon = 0
  l = dimensions[:l]
  w = dimensions[:w]
  h = dimensions[:h]

  dim_array = [l, w, h]
  max_side = dim_array.max
  dim_array.delete_at(dim_array.index(max_side))

  perimeter = (dim_array.first * 2) + (dim_array.last * 2)
  cubic = l * w * h

  ribbon = cubic + perimeter

  return ribbon
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

puts ribbon_calculator("input.txt")
# puts wrap_calculator("input_short.txt")
