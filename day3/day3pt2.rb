class PackSorter
  PRIORITY = ("a".."z").to_a + ("A".."Z").to_a

  def initialize(path)
    @file = File.open(path)
  end

  def lines
    @file.readlines
  end

  def groups
    groups = []
    group = []
    lines.each do |line|
      group << line
      if group.length == 3
        groups << group
        group = []
      end
    end
    groups
  end

  def group_checker(group)
    group[0].chars.find do |char|
      group[1].include?(char) && group[2].include?(char)
    end
  end

  def char_to_priority(char)
    PRIORITY.find_index(char) + 1 
  end

  def total
    groups.sum do |group|
      char_to_priority(group_checker(group))
    end
  end
end

p PackSorter.new('./input.txt').total