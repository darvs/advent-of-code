# frozen_string_literal: true

# A sequence of binary digits
class BitSequence
  attr_reader :digits, :error

  LENGTH_TYPE_TOTAL_LENGTH_IN_BITS = 0
  LENGTH_TYPE_NUMBER_OF_SUBPACKETS = 1

  def initialize(list, len = 0)
    @error = false

    len = list.length if len.zero?

    @digits = list.slice!(0..(len - 1))
  end

  def to_i
    @digits.map(&:to_s).reduce(&:+).to_i(2)
  end

  def read_version
    Version.new(@digits).to_i
  end

  def read_type
    Type.new(@digits).to_i
  end

  def read_literal
    Literal.new(@digits).to_i
  end

  def read_length_type
    LengthType.new(@digits).to_i
  end

  def read_number_of_bits
    NumberOfBits.new(@digits).to_i
  end

  def read_number_of_subpackets
    NumberOfSubpackets.new(@digits).to_i
  end

  def read_subpackets
    lt = read_length_type
    case lt
    when 0
      nbits = read_number_of_bits
      list = []
      subdigits = @digits.slice!(0..(nbits - 1))
      until subdigits.empty?
        another = Packet.new(subdigits)
        list << another
        subdigits = another.digits # leftover digits
      end
      list
    when 1
      nsubp = read_number_of_subpackets
      (1..nsubp).each_with_object([]){|_, list2|
        another = Packet.new(@digits)
        list2 << another
        @digits = another.digits # reclaim lefover digits
      }
    end
  end
end

# Version is 3 digits
class Version < BitSequence
  def initialize(list)
    super(list, 3)
  end
end

# Version is 3 digits
class Type < BitSequence
  def initialize(list)
    super(list, 3)
  end
end

# The length type determines the type of subpackets
class LengthType < BitSequence
  def initialize(list)
    super(list, 1)
  end
end

# This number of bits describes subpackets
class NumberOfBits < BitSequence
  def initialize(list)
    super(list, 15)
  end
end

# This number of subpackets are still to be read
class NumberOfSubpackets < BitSequence
  def initialize(list)
    super(list, 11)
  end
end

# A literal is a bit sequence packed 5 bits at a time
class Literal < BitSequence
  def initialize(list)
    value = []
    loop {
      continue = list.slice!(0)
      value << list.slice!(0..3)
      break if continue.zero?
    }
    super(value.flatten)
  end

  def to_s
    "Literal #{@digits}"
  end
end

# A generic packet
class Packet < BitSequence
  attr_reader :version, :type

  LITERAL = 4

  TYPE = { 4 => :literal,
           0 => :sum,
           1 => :mult,
           2 => :min,
           3 => :max,
           5 => :gt,
           6 => :lt,
           7 => :eq }.freeze

  def initialize(list, len = 0)
    super(list, len)

    @version = read_version
    @type = read_type
    @literal_value = nil

    @subpackets = []

    case @type
    when LITERAL
      @literal_value = read_literal
    else
      @subpackets = read_subpackets
    end
  end

  def to_s
    s = ''

    case TYPE[@type]
    when :literal
      s += @literal_value.to_s
    else
      s += "#{TYPE[@type]}("
      s += @subpackets.map(&:to_s).join(',')
      s += ')'
    end
    s
  end

  def sum_of_versions
    version + @subpackets.map{|subp| subp.sum_of_versions}.sum
  end

  def solve
    case TYPE[@type]
    when :literal
      @literal_value
    when :sum
      @subpackets.map(&:solve).reduce(&:+)
    when :mult
      @subpackets.map(&:solve).reduce(&:*)
    when :min
      @subpackets.map(&:solve).min
    when :max
      @subpackets.map(&:solve).max
    when :gt
      @subpackets[0].solve > @subpackets[1].solve ? 1 : 0
    when :lt
      @subpackets[0].solve < @subpackets[1].solve ? 1 : 0
    when :eq
      @subpackets[0].solve == @subpackets[1].solve ? 1 : 0
    end
  end
end

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class PacketDecoder
  HEX_DIGITS = %w[0 1 2 3 4 5 6 7 8 9 A B C D E F].freeze

  def initialize(string)
    @bits = string.chars.map{|digit| HEX_DIGITS.find_index(digit)}.map{|v| format('%04s', v.to_s(2))}.map(&:chars).flatten.map(&:to_i)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?).join)
  end

  def self.from_string(s)
    new(s)
  end

  def version
    main = Packet.new(@bits)
    main.version
  end

  def sum_of_versions
    main = Packet.new(@bits)
    main.sum_of_versions
  end

  def solve
    main = Packet.new(@bits)
    main.solve
  end

end
