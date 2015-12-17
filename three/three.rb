require 'pry'

def deliver(filename)
  file_data = read_file(filename)
  grid = get_grid(file_data[0])

  return grid.length

end

def get_grid(data)
  grid = {}
  x = 0
  y = 0
  grid[get_coords(x, y)] = 0

  data.split("").each do |direction|
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
