# frozen_string_literal: true

require 'open3'

# Generator
class Generator
  def initialize(lines)
    @lines = Array.new(lines)
    @program = []

    code('#include "stdio.h"')
    code('long accepted = 0;')
    parse_instructions
    parse_calls
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def code(str)
    @program.append(str)
  end

  def parse_instruction_part(part)
    first, last = part.split(':')
    if last.nil?
      code("    goto #{first};")
    else
      code("    if (#{first}) goto #{last};")
    end
  end

  def parse_instructions
    code('void test(int x, int m, int a, int s)')
    code('{')
    code('  goto in;')

    @lines.each_with_index{|l, num|
      if l.empty?
        @lines = @lines.drop(num + 1)
        break
      end

      label, rest = l.split('{')
      instructions, = rest.split('}')
      code("  #{label}:")
      instructions.split(',').each{|part| parse_instruction_part(part)}
    }

    code('  A:')
    code('    accepted += (x+m+a+s);')
    code('  R:')
    code('}')
    code('')
  end

  def parse_calls
    code('int main()')
    code('{')

    @lines.each{|l|
      matches = l.scan(/x=(\d+),m=(\d+),a=(\d+),s=(\d+)/)
      code("  test( #{matches.join(',')} );")
    }

    code('  printf("%ld\\n", accepted);')

    code('  return 0;')
    code('}')
  end

  def run
    stdout = ''
    Dir.mktmpdir{|tmp|
      @tmp = tmp
      Dir.chdir(tmp) {
        filename = '2319.c'
        File.open(filename, 'w') {|file|
          @program.each{|l|
            #puts(l)
            file.puts(l)
          }
        }

        #puts `pwd; ls -lah`

        stdout, = Open3.capture2('gcc -o 2319 2319.c')
        puts "compile #{stdout}"

        stdout, = Open3.capture2('./2319')
        puts "run #{stdout}"
      }
    }

    stdout.strip.to_i
  end
end
