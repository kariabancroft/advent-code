require 'pry'
require 'set'

TOTAL_LITERS = 150

def containers(filename)
  data = read_file(filename)
  count = combinations(data)
  return count
end

def min_combos(data)
  sorted_data = data.sort.reverse
  total = 0
  count = 0
  sorted_data.each do |d|
    total += d
    count += 1
    break if total >= TOTAL_LITERS
  end

  return count
end

def combinations(data)
  min_combos = min_combos(data)

  solutions = (min_combos..data.length).reduce([]) do |temp, num_combos|
    temp.concat(data.combination(num_combos).select do |x|
      x.inject(:+) == 150
    end)
  end

  return solutions.length
end

def read_file(filename)
  file = []
  File.open(filename, "r") do |f|
    f.each_line do |line|
      file << line.to_i
    end
  end
  return file
end

puts containers("input.txt")
# puts containers("input-short.txt")
