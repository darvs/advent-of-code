# frozen_string_literal: true

# Crab Cups
class Cups
  def initialize(list)
    @list = list

  end

  def self.from_order(string)
    new(string.chars.map(&:to_i))
  end

  def moves(nb_moves)
    total_moves = nb_moves
    current = 0

    puts "-------------"
    puts "total_moves #{total_moves}"

    until nb_moves.zero?
      
      puts "++ current #{@list[current]} @ #{current}"
      label = @list[current]

      # Delete the 3 cups after the current one
      removed = []
      delete_index = (current + 1) % @list.length
      3.times{
        delete_index = 0 if delete_index == @list.length
        removed << @list.delete_at(delete_index)
      }

      puts "removed #{removed} list #{@list}"

      # Find the destination cup
      dest = label - 1
      loop do
        break if @list.include?(dest)

        if dest < @list.min
          dest = @list.max
          break
        end
        dest -= 1
      end

      # Insert after destination
      insert_index = @list.index(dest) + 1
      puts "insert_index #{insert_index}"
      insert_index = -1 if insert_index == @list.length
      @list = @list.insert(insert_index, removed).flatten
      puts "reinserted #{@list}"

      puts "current #{current} list.length #{@list.length}"
      current = (@list.index(label) + 1) % @list.length

      nb_moves -= 1
    end

    puts "current-1 #{@list[current-1]} @#{current-1} total_moves #{total_moves} list #{@list}"
    #@list = @list.rotate((current - 1 - total_moves - 1) % @list.length)
    @list = @list.rotate(current-1 - (total_moves-1))

    @list.map(&:to_s).join
  end

  def formatted_moves(nb_moves)
    before, after = moves(nb_moves).split('1')
    puts "before #{before} after #{after}"
    after + before
  end

end
