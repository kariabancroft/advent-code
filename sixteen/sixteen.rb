require 'pry'

def aunt_sues(filename)
  data = read_file(filename)
  puts match(data, solution)
end

def match(data, solution)
  sues = []

  data.each do |sue|
    sue_count = 0
    sue.each do |key, value|
      if solution.include?(key)
        if solution[key] == value
          sue_count += 1
        end
      end
    end

    sues << sue[:id] if sue_count >= 3
  end

  return sues
end

def solution
  return {
    "children" => 3,
    "cats" =>  7,
    "samoyeds" =>  2,
    "pomeranians" =>  3,
    "akitas" =>  0,
    "vizslas" =>  0,
    "goldfish" =>  5,
    "trees" =>  3,
    "cars" =>  2,
    "perfumes" =>  1
  }
end

def convert_input(row)
  h = {}
  row = row[4..row.length - 1]
  data_pieces = row.split(" ")
  # puts "Data: #{data_pieces}"
  h[:id] = data_pieces[0].chomp(":").to_i

  (1..data_pieces.length - 1).each do |i|
    if i % 2 == 1
      key = data_pieces[i].chomp(":")
      value = data_pieces[i + 1].chomp(",")
      h[key] = value.to_i
    end
  end

  return h
end

def read_file(filename)
  file = []
  File.open(filename, "r") do |f|
    f.each_line do |line|
      file << convert_input(line)
    end
  end
  return file
end

puts aunt_sues("input.txt")
