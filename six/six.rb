require 'pry'
GRID_SIZE = 1000

def christmas_lights(filename)
  grid = create_grid
  instructions_text = read_file(filename)

  instructions_text.each do |inst_string|
    instruction = read_instruction(inst_string)
    grid = light_action(instruction, grid)
  end

  return count_lights(grid)
end

def create_grid
  grid = Array.new(GRID_SIZE)
  grid.length.times do |i|
     grid[i] = Array.new(GRID_SIZE, false)
  end

  return grid
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

def print_grid(grid)
  grid.each do |x|
    x.each do |y|
      if y
        print 1
      else
        print 0
      end
    end
    puts
  end
end


def light_action(instruction, grid)
  # puts instruction
  # print_grid(grid)
  (instruction[:first][:x]..instruction[:second][:x]).each do |x|
    (instruction[:first][:y]..instruction[:second][:y]).each do |y|
      case instruction[:light]
      when 1
        grid[x][y] = true
      when 0
        grid[x][y] = false
      when -1
        grid[x][y] = !grid[x][y]
      end
      # print_grid(grid)
    end
  end

  return grid
end


def read_instruction(row)
  row_items = row.split(" ")

  # Delete unnecessary data
  if row_items[0] == "turn"
    row_items.delete_at(0)
  end
  row_items.delete_at(-2)

  instruction = {}

  case row_items[0]
  when "on"
    instruction[:light] = 1
  when "off"
    instruction[:light] = 0
  when "toggle"
    instruction[:light] = -1
  end

  first_coord = row_items[1].split(",")
  second_coord = row_items[2].split(",")
  instruction[:first] = { x: first_coord.first.to_i, y: first_coord.last.to_i }
  instruction[:second] = { x: second_coord.first.to_i, y: second_coord.last.to_i }

  return instruction
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

# puts read_instruction("turn off 370,39 through 425,839")
 puts christmas_lights("input.txt")
# puts christmas_lights("input-short.txt")
