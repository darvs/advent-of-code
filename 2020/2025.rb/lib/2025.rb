# frozen_string_literal: true

# PublicKeys
class PublicKeys
  def initialize(list)
    @card_pk = list.first.to_i
    @door_pk = list.drop(1).first.to_i
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def encryption_key
    card_loop_size = 0
    value = 1

    until value == @card_pk
      value *= 7
      value %= 20201227
      card_loop_size += 1
    end

    value = 1
    card_loop_size.times.each{
      value *= @door_pk
      value %= 20201227
    }

    value
  end
end
