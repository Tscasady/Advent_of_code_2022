module RPS
  class Calculator
    def initialize(path)
      @file = File.open(path)
    end

    def lines
      @file.readlines
    end

    def total
      lines.sum do |line|
        data = line.split(' ')
        opp = data[0]
        result = data[1]
        Round.new(opp, result).points
      end
    end
  end

  class Round
    def initialize(opp, result)
      @opp = RPSFactory.for(opp)
      @plyr = RPSFactory.for(@opp.outcome(result))
    end

    def points
      points = 0
      points += @plyr.points
      return points += 3 if @plyr == @opp
      points += @plyr.fight(@opp)
    end
  end

  class Play
    attr_reader :points

    def ==(other)
      @points == other.points
    end
  end

  class Rock < Play
    def initialize
      @points = 1
    end

    def fight(other)
      if other.is_a?(Paper)
        0
      else
        6
      end
    end

    def outcome(result)
      if result == "X"
        "C"
      elsif result == "Y"
        "A"
      else
        "B"
      end
    end
  end

  class Paper < Play
    def initialize
      @points = 2
    end

    def fight(other)
      if other.is_a?(Scissors)
        0
      else
        6
      end
    end

    def outcome(result)
      if result == "X"
        "A"
      elsif result == "Y"
        "B"
      else
        "C"
      end
    end
  end

  class Scissors < Play
    def initialize
      @points = 3
    end

    def fight(other)
      if other.is_a?(Rock)
        0
      else
        6
      end
    end

    def outcome(result)
      if result == "X"
        "B"
      elsif result == "Y"
        "C"
      else
        "A"
      end
    end
  end
  
  class RPSFactory
    PLAYS = {
      "A" => Rock, 
      "X" => Rock, 
      "B" => Paper, 
      "Y" => Paper, 
      "C" => Scissors,
      "Z" => Scissors
    }

    def self.for(input)
     PLAYS[input].new 
    end
  end
end

p RPS::Calculator.new('./input.txt').total
