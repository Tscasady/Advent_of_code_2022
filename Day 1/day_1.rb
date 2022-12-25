class CalorieCalculator
  def initialize(path)
    @food_list = File.open(path)
  end

  def lines
    @food_list.readlines
  end

  def calories_per_elf
    elves = []
    elf = []
    lines.each do  |line|
      if line == "\n"
        elves << elf
        elf = []
      else 
        elf << line.to_i
      end
    end
    elves
  end

  def most_calories
    calories_per_elf.map(&:sum)
  end

  def top_calories(n)
    most_calories.sort.reverse.first(n)
  end

  def total_top_calories(n)
    top_calories(n).sum
  end
end

p CalorieCalculator.new('./input.txt').total_top_calories(3)