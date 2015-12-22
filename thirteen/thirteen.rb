require 'pry'

def optimal_seating(filename)
  data = read_file(filename)
  all_attendees = data.map{|d| d[:first]}.uniq

  # puts "All attendees: #{all_attendees}"
  permutations = all_attendees.permutation.to_a
  puts "So many permutations #{permutations.length}"
  # puts "All permutations: #{permutations}"
  all_scores = get_all_scores(permutations, data)
  # puts all_scores
  return all_scores.max
end

def get_all_scores(permutations, data)
  scores = []
  permutations.each do |p|
    # puts "Permutation: #{p}"
    scores << get_score(p, data)
  end
  return scores
end

def get_score(one_combo, all_data)
  total = 0
  # Go from last element, around the whole "circle"
  (-1..one_combo.length - 1).each do |index|
    attendee = one_combo[index]
    next_person = one_combo[index + 1]
    break if next_person.nil?

    one = all_data.find do |d|
      d[:first] == attendee && d[:second] == next_person
    end
    two = all_data.find do |d|
      d[:second] == attendee && d[:first] == next_person
    end

    total += one[:score]
    total += two[:score]
  end
  # puts
  return total
end

def convert_input(row)
  row_data = row.split(" ")
  happiness = {}
  happiness[:first] = row_data.first
  happiness[:second] = row_data.last.chomp(".")
  happiness[:score] = row_data[3].to_i
  if row_data[2] == "lose"
    happiness[:score] = happiness[:score] * -1
  end
  return happiness
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

# puts optimal_seating("input-short.txt")
puts optimal_seating("input.txt")
