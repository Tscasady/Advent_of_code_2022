class PackSorter
  PRIORITY = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(path)
    @file = File.open(path)
  end

  def lines
    @file.readlines
  end

  def line_splitter(line)
    mid = line.length / 2
    pair = [line.slice(0, mid), line.slice(mid..)]
  end

  def pair_checker(pair)
    pair[0].chars.find do |char|
      pair[1].include?(char)
    end
  end

  def char_to_priority(char)
    PRIORITY.find_index(char) + 1 
  end

  def total
    lines.sum do |line|
      char_to_priority(pair_checker(line_splitter(line)))
    end
  end
end

p PackSorter.new('./input.txt').total