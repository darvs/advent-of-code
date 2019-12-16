# frozen_string_literal: true

Given('the code positions in file {string}') do |string|
  @intcode = IntcodeInterpreter.from_file(string)
end

When('the program has completed its run') do
  @intcode.run
end

Then('there should be {int} block tiles on the screen') do |int|
  @mame = Mame.new(@intcode.output)
  @mame.display
  expect(@mame.count_blocks).to eq(int)
end
