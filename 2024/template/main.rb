# frozen_string_literal: true

# Program
class Program
  def initialize(str)
    # init if needed
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def run
    42
  end
end
