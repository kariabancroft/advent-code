require 'pry'

def deliver(filename)
  file_data = read_file(filename)
  santa_data, robo_data = split_grid(file_data[0])
  santa_grid = process_grid(santa_data)
  robo_grid = process_grid(robo_data)

  final_grid = santa_grid.merge(robo_grid)
  return final_grid.length
end

def split_grid(data)
  data_array = data.split("")
  santa_data = []
  robo_data = []
  data_array.each_with_index do |d, index|
    if index % 2 == 0
      santa_data << d
    else
      robo_data << d
    end
  end

  return santa_data, robo_data
end

def process_grid(data)
  grid = {}
  x = 0
  y = 0
  grid[get_coords(x, y)] = 0

  data.each do |direction|
    # Add one to the existing location

    grid[get_coords(x,y)] += 1

    case direction
    when "^"
      # north
      y += 1
    when "v"
      # south
      y -= 1
    when ">"
      # east
      x += 1
    when "<"
      # west
      x -= 1
    end

    upd_coords = get_coords(x,y)
    if grid[upd_coords].nil?
      grid[upd_coords] = 0
    end

    grid[upd_coords] += 1
  end

  return grid
end

def get_coords(x, y)
  return {x: x, y: y}
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

 puts deliver("input.txt")
# puts deliver("input-short.txt")
