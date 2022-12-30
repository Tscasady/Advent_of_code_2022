class Organizer
  
  def initialize(path)
    @file = File.open(path)
    @stacks = [
    ["V", "C", "D", "R", "Z", "G", "B", "W"], 
    ["G", "W", "F", "C", "B", "S", "T", "V"], 
    ["C", "B", "S", "N", "W"], 
    ["Q", "G", "M", "N", "J", "V", "C", "P"], 
    ["T", "S", "L", "F", "D", "H", "B"], 
    ["J", "V", "T", "W", "M", "N"],
    ["P", "F", "L", "C", "S", "T", "G"],
    ["B", "D", "Z"],
    ["M", "N", "Z", "W"]] 
  end

  def lines
   @file.readlines 
  end
  
  def move_lines
    lines.slice(10..)
  end

  def line_sanitizer(line)
    line.gsub(/[a-z]/, "").split(' ').map(&:to_i)
  end

  def move(move_data)
    number_to_move = move_data[0]
    source = move_data[1] - 1
    destination = move_data[2] - 1
    @stacks[destination] << @stacks[source].pop(number_to_move)
    @stacks[destination].flatten!
  end

  def tops
    move_lines.each do |line|
      move(line_sanitizer(line))
    end
    @stacks.map(&:pop)
  end
end

p Organizer.new('./input.txt').tops.join
