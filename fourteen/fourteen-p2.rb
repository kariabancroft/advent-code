require 'pry'

def winning_distance(filename, seconds)
  reindeer_info = read_file(filename)
  # puts reindeer_info
  all_distances = reindeer_distances(reindeer_info, seconds)

  return get_distance_points(all_distances, seconds)
end

def get_distance_points(distances, seconds)
  points = Array.new(distances.length, 0)

  # for each second
  (0...seconds).each do |second|
    # Get one second of data across all reindeer
    second_data = distances.map { |row| row[second] }
    max = second_data.max

    # Get the indexes that match the max
    indexes = second_data.each_index.select{ |j| second_data[j] == max}

    # Increment the score for each individual
    # reindeer that matches the max
    indexes.each do |index_val|
      points[index_val] += 1
    end
  end

  # Return the largest number of points
  return points.max
end

def reindeer_distances(reindeer_info, seconds)
  distances = []

  reindeer_info.each do |reindeer|
    distances << get_distance(reindeer, seconds)
  end

  return distances
end

def get_distance(reindeer, seconds)
  seconds_passed = 0
  distance = 0
  distances = []

  while seconds_passed <= seconds
    if reindeer[:time] + seconds_passed <= seconds
      reindeer[:time].times do
        distance += reindeer[:dist]
        distances << distance
      end
      # distance += reindeer[:time] * reindeer[:dist]
      seconds_passed += reindeer[:time]
    else
      difference = seconds - seconds_passed
      difference.times do
        distance += reindeer[:dist]
        distances << distance
      end
      # distance += difference * reindeer[:dist]
      break
    end

    if reindeer[:rest] + seconds_passed <= seconds
      seconds_passed += reindeer[:rest]
      reindeer[:rest].times do
        distances << distance
      end
    else
      difference = seconds - seconds_passed
      difference.times do
        distances << distance
      end
      break
    end
  end

  puts "Reindeer #{reindeer[:name]} travels #{distance}"
  puts "Distances length #{distances.length}"
  return distances
end

def convert_input(line)
  reindeer = {}
  data = line.split(" ")
  reindeer[:name] = data[0]
  reindeer[:dist] = data[3].to_i
  reindeer[:time] = data[6].to_i
  reindeer[:rest] = data[-2].to_i
  return reindeer
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

puts winning_distance("input.txt", 2503)
# puts winning_distance("input-short.txt", 1000)
