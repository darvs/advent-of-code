# frozen_string_literal: true

Given('the program in file {string}') do |string|
  @filename = string
end

#Given('the input {string}') do |string|
  #@pgm.input = string
#end

When('the machine is run') do
  @robot = PaintingRobot.new(@filename)
end

When('the machine starts on a black panel') do
  @robot = PaintingRobot.new(@filename, 0)
end

When('the machine starts on a white panel') do
  @robot = PaintingRobot.new(@filename, 1)
end

#Then('the output should be {string}') do |string|
  #expect(@pgm.output).to eq(string)
#end

Then('{int} panels should have been painted') do |int|
  expect(@robot.painted).to eq(int)
end

Then('show the picture painted') do
  @robot.paint
end
