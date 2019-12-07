# frozen_string_literal: true

Given('a program of {string}') do |string|
  @pgm = string
end

Given('the program in file {string}') do |string|
  @pgm = MultiCPUIntcodeInterpreter.read_file(string)
end

When('phase setting sequence is {string}') do |string|
  @seq = string
end

When('the machine is run') do
  @out = MultiCPUIntcodeInterpreter.new(@pgm).with_input(@seq).seq
end

When('all settings are run') do
  @out = MultiCPUIntcodeInterpreter.max_thruster_signal(@pgm)
end

When('amplifiers are connected in a feedback loop') do
  @out = MultiCPUIntcodeInterpreter.feedback_loop(@pgm, @seq)
end

When('all settings are tried in a feedback loop') do
  @out = MultiCPUIntcodeInterpreter.all_settings_feedback_loop(@pgm)
end

Then('the max thruster signal should be {int}') do |int|
  expect(@out).to eq(int)
end
