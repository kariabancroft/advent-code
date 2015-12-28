require 'pry'

def winning_distance(filename, seconds)
  reindeer_info = read_file(filename)
  # puts reindeer_info
  all_distances = reindeer_distances(reindeer_info, seconds)
  return all_distances.max
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

  while seconds_passed <= seconds
    if reindeer[:time] + seconds_passed <= seconds
      distance += reindeer[:time] * reindeer[:dist]
      seconds_passed += reindeer[:time]
    else
      difference = seconds - seconds_passed
      distance += difference * reindeer[:dist]
      break
      # reindeer[:time].times do
      #   break if seconds_passed >= seconds
      #
      #   distance += reindeer[:dist]
      #   seconds_passed += 1
      # end
    end

    if reindeer[:rest] + seconds_passed <= seconds
      seconds_passed += reindeer[:rest]
    else
      break
    end
    # reindeer[:rest].times do
    #   break if seconds_passed >= seconds
    #
    #   seconds_passed += 1
    # end
  end

  puts "Reindeer #{reindeer[:name]} travels #{distance}"

  return distance
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
