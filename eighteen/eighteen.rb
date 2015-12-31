require 'pry'

GRID_SIZE = 100
STEPS = 100
DELTAS = [
  {x: -1, y: -1},
  {x: 0, y: -1},
  {x: 1, y: -1},
  {x: -1, y: 0},
  {x: 1, y: 0},
  {x: -1, y: 1},
  {x: 0, y: 1},
  {x: 1, y: 1}
]

def animation(filename)
  grid = create_grid
  grid = create_initial_configuration(grid, filename)
  print_grid(grid)
  # puts DELTAS
  grid = animate_steps(grid)
  return count_lights(grid)
end


def count_lights(grid)
  count = 0

  grid.each do |x|
    x.each do |y|
      count += 1 if y
    end
  end

  return count
end

def animate_steps(grid)
  STEPS.times do
    grid = animate(grid)
  end
  return grid
end

def animate(grid)
  # Create a new duplicate grid that will contain our changes
  new_grid = Marshal.load(Marshal.dump(grid))

  (0...GRID_SIZE).each do |x|
    (0...GRID_SIZE).each do |y|
      # print_grid(grid)
      neighbors_count = neighbors_count(grid, x, y)

      case grid[x][y]
      when true
        # turn off if anything other than 2 or 3 neighbors on
        # binding.pry
        new_grid[x][y] = false if ![2,3].include?(neighbors_count)
      when false
        # turn on if exactly three neighbors
        # binding.pry
        new_grid[x][y] = true if neighbors_count == 3
      end
    end
  end

  # print_grid(new_grid)
  return new_grid
end

def neighbors_count(grid, x, y)
  count = 0

  DELTAS.each do |delta|
    # Do some boundary checking
    check_x = x + delta[:x]
    check_y = y + delta[:y]
    if check_x < 0 || check_x >= GRID_SIZE ||
      check_y < 0 || check_y >= GRID_SIZE
      # do nothing
    elsif grid[check_x][check_y]
      count += 1
    end

  end
# binding.pry
  return count
end

def create_grid
  grid = Array.new(GRID_SIZE)
  grid.length.times do |i|
     grid[i] = Array.new(GRID_SIZE, false)
  end

  return grid
end

def print_grid(grid)
  grid.each do |x|
    x.each do |y|
      if y
        print "#"
      else
        print "."
      end
    end
    puts
  end
  puts
end

def create_initial_configuration(grid, filename)
  File.open(filename, "r") do |f|
    f.each_line.with_index do |line, row_index|
      line.split("").each_with_index do |char, char_index|
        if char == "#"
          grid[row_index][char_index] = true
        end
      end
    end
  end
  return grid
end

# puts animation("input-short.txt")
puts animation("input.txt")
