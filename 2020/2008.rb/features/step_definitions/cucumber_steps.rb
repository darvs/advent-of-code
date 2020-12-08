# frozen_string_literal: true

Given('the program in {string}') do |string|
  @program = string
end

Then('{int} is in the accumulator just before any instruction is executed a second time.') do |int|
  expect(Debugger.from_file(@program).check_loop).to eq(int)
end
