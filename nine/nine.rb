require 'pry'

def shortest_route(filename)
  trip_data = read_file(filename)
  start_locations = trip_data.map{|d| d[:start]}.uniq
  end_locations = trip_data.map{|d| d[:end]}.uniq
  all_locations = start_locations | end_locations
  permutations = all_locations.permutation.to_a

  distances = get_total(permutations, trip_data)
  # print distances
  return distances.min
end


def get_total(permutations, trip_data)
  total_array = []
  permutations.each do |perm|
    count = 0
    perm.each_with_index do |loc, index|
      if index + 1 < perm.length
        first_match = trip_data.find{ |d| d[:start] == loc && d[:end] == perm[index + 1] }
        second_match = trip_data.find{ |d| d[:end] == loc && d[:start] == perm[index + 1] }

        if first_match.nil? && second_match.nil?
          count = 0
          break
        elsif first_match.nil?
          count += second_match[:dist]
        elsif second_match.nil?
          count += first_match[:dist]
        end
      end
    end

    total_array << count if count > 0
  end
  return total_array
end

def read_line(line)
  read = {}
  line_data = line.split(" ")
  read[:start] = line_data[0]
  read[:end] = line_data[2]
  read[:dist] = line_data.last.to_i
  return read
end

def read_file(filename)
  file = []
  File.open(filename, "r") do |f|
    f.each_line do |line|
      file << read_line(line)
    end
  end
  return file
end

puts shortest_route("input.txt")
