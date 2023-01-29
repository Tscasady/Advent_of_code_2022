require './IO'

class Tuner
  def initialize(input = Input.new('./day6/input.txt'))
    @lines = input.lines.first
  end

  def duplicate?(chunk)
    chunk.any?{ |letter| chunk.count(letter) > 1 }
  end

  def check_line
    result = []
    @lines.chars.each_index do |index|
      if !(duplicate?(@lines.chars.slice(index, 14)))
        result << @lines.chars.slice(0, index + 14)
        break
      end
    end
    result.flatten.length
  end
end

puts Tuner.new.check_line
