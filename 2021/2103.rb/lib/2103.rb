# frozen_string_literal: true

# Binary Diagnostic
class BinaryDiagnostic
  def initialize(list)
    @list = list
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip))
  end

  def run
    @list.map(&:chars)
         .transpose
         .map{|x| x.group_by(&:itself).map{|k, v| [k, v.count]}}
         .map{|x| x.sort{|a, b| b[1] <=> a[1]}}
         .map{|x| x.map{|k, _| k[0]}}
         .transpose
         .map{|x| x.reduce(&:concat).to_i(2)}
         .reduce(&:*)
  end
end
