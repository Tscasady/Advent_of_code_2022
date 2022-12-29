class CampSection
  def initialize(path)
    @file = File.open(path)
  end

  def lines 
    @file.readlines
  end

  def chunk_formatter(chunk)
    range = chunk.chomp.split('-')
    (range[0]..range[1]).to_a
  end

  def contains?(line)
    chunks = line.split(',')
    chunks.map!{|chunk| chunk_formatter(chunk) }
    test1 = (chunks[0] - chunks[1]).length
    test2 = (chunks[1] - chunks[0]).length
    test1 == 0 || test2 == 0
  end

  def overlap?(line)
    chunks = line.split(',')
    chunks.map!{|chunk| chunk_formatter(chunk) }
    (chunks[0] - chunks[1]).length != chunks[0].length
  end

  def total_contains
    lines.select do |line|
      contains?(line)
    end.count
  end

  def total_overlap
    lines.select do |line|
      overlap?(line)
    end.count
  end
end

p CampSection.new('./input.txt').total_overlap