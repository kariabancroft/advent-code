require 'pry'

TOTAL_TEAS = 100
I_COUNT = 4

def best_cookies(filename)
  data = read_file(filename)
  options = create_options
  scores = get_scores(data, options)
  return scores.max
end

def get_scores(data, options)
  scores = []

  # UGH WHY SO BRUTE FORCE
  options.each do |opt|
    total_cap = 0
    total_dur = 0
    total_flav = 0
    total_text = 0
    (0..I_COUNT - 1).each do |i|
      total_cap += cap_score(data[i], opt[i])
      total_dur += dur_score(data[i], opt[i])
      total_flav += fla_score(data[i], opt[i])
      total_text += text_score(data[i], opt[i])
    end
    if (total_cap > 0) && (total_dur > 0) && (total_flav > 0) && (total_text > 0)
      total = (total_cap * total_dur * total_flav * total_text)
      scores << total
    end

  end

  return scores
end

def cap_score(ingredient, teas)
  return ingredient["capacity"] * teas
end

def dur_score(ingredient, teas)
  return ingredient["durability"] * teas
end

def fla_score(ingredient, teas)
  return ingredient["flavor"] * teas
end

def text_score(ingredient, teas)
  return ingredient["texture"] * teas
end

def create_options
  options = []

  # UGH WHY SO BRUTE FORCE
  (1..100).each do |i|
    (1..100).each do |j|
      (1..100).each do |k|
        (1..100).each do |l|
          if (i + j + k + l) == 100
            options << [i, j, k, l]
          end
        end
      end
    end
  end

  return options
end

def convert_input(line)
  ingred = {}

  first_split = line.split(":")
  ingred[:name] = first_split[0]
  second_set = first_split[1].chomp
  second_set = second_set.split(" ")

  9.times do |i|
    if i % 2 == 0
      ingred[second_set[i]] = second_set[i + 1].to_i
    end
  end

  return ingred
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

puts best_cookies("input.txt")
