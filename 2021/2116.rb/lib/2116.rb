# frozen_string_literal: true

# A sequence of binary digits
class BitSequence
  attr_reader :digits, :error

  LENGTH_TYPE_TOTAL_LENGTH_IN_BITS = 0
  LENGTH_TYPE_NUMBER_OF_SUBPACKETS = 1

  def initialize(list, len = 0)
    @error = false

    if list.nil? || list.empty?
      @error = true
      @digits = [0]
      p "error??"
      return
    end

    len = list.length if len.zero?

    @digits = list.slice!(0..(len - 1))

    if @digits.nil? || @digits.empty?
      @digits = [0]
      @error = true
      p "error???"
    end
  end

  def to_i
    p "@digits #{@digits}"
    @digits.map(&:to_s).reduce(&:+).to_i(2)
  end

  def read_version
    Version.new(@digits).to_i
  end

  def read_type
    p "Read Type : #{@digits}"
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
      p '!!ZERO'
      nbits = read_number_of_bits
      list = []
      subdigits = @digits.slice!(0..(nbits-1))
      until subdigits.empty?
        p "Remaining digits #{subdigits}"
        another = Packet.new(subdigits)
        if another.error
          p "error" 
        else
          p "Built"
          list << another
          subdigits = another.digits # leftover digits
        end
      end
      list
    when 1
      p '!!ONE'
      nsubp = read_number_of_subpackets
      p "#{nsubp} subpackets to read..."
      (1..nsubp).each_with_object([]){|_, list2|
        p 'reading subpacket...'
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

  def initialize(list, len = 0)
    super(list, len)

    @version = read_version
    @type = read_type
    @literal_value = nil

    @subpackets = []

    case type
    when LITERAL
      @literal_value = read_literal
      p "literal #{@literal_value}"
    else
      @subpackets = read_subpackets
    end
  end

  def to_s
    s = "{Version #{@version}"
    s += ' Type: '
    s += @type == LITERAL ? "LITERAL(#{@literal_value})" : @type.to_s
    s += '[ '
    s += @subpackets.map(&:to_s).join(', ')
    s += '] '
    s += '}'

    s
  end

  def sum_of_versions
    version + @subpackets.map{|subp| subp.sum_of_versions}.sum
  end
end

# ph'nglui mglw'nafh Cthulhu R'lyeh wgah'nagl fhtagn
class PacketDecoder
  HEX_DIGITS = %w[0 1 2 3 4 5 6 7 8 9 A B C D E F].freeze

  def initialize(string)
    p "init from string #{string}"
    p @bits = string.chars.map{|digit| HEX_DIGITS.find_index(digit)}.map{|v| format('%04s', v.to_s(2))}.map(&:chars).flatten.map(&:to_i)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:strip).reject(&:empty?).join)
  end

  def self.from_string(s)
    p "from_string #{s}"
    new(s)
  end

  def version
    main = Packet.new(@bits)
    p "Packet: #{main}"
    main.version
  end

  def sum_of_versions
    main = Packet.new(@bits)
    p "Packet: #{main}"
    main.sum_of_versions
  end
end
