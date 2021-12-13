# frozen_string_literal: true

Given('the points in file {string}') do |arg1|
  @origami = Origami.from_file(arg1)
end

Given('after just {int} fold') do |arg1|
  @origami.limit(arg1)
end

Then('there is {int} dots visible') do |arg1|
  @origami.fold
  expect(@origami.dots).to eq(arg1)
end

Then('display the results') do
  @origami.fold
  @origami.display
end
