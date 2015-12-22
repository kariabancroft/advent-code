require "pry"

def accounting(filename)
  file_data = read_file(filename)
  more_data = eval(file_data.first)
  return parse_data(more_data)
end

def parse_data(data)
  count = 0
  puts data
  data.each do |d|
    if iterable?(d)
      count += parse_data(d)
    else
      if d.class == Fixnum
        count += d
      end
    end
  end
  return count
end

def iterable?(object)
  object.respond_to? :each
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

puts accounting("input-short.txt")
