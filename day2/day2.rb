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
        moves = line.split(' ')
        opp = moves[0]
        plyr = moves[1]
        puts opp
        puts plyr
        puts Round.new(opp, plyr).points
        Round.new(opp, plyr).points
      end
    end
  end

  class Round
    def initialize(opp, plyr)
      @opp = RPSFactory.for(opp)
      @plyr = RPSFactory.for(plyr)
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
      return 0 if @points == other.points
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
