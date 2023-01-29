class Input
  def initialize(path = './input.txt')
    @input = File.open(path)
  end

  def lines
    @input.readlines 
  end
end
