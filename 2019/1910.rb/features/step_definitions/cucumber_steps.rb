# frozen_string_literal: true

Given('the map in {string}') do |string|
  @asteroids = Asteroids.from_file(string)
end

Then('the most asteroids detected would be {int}') do |int|
  expect(@asteroids.most_detected).to eq(int)
end

Then('the best position would be {string}') do |string|
  expect(@asteroids.best_position.to_s).to eq(string)
end

When('asteroids are blasted in order') do
  @asteroids.blast
end

Then('vaporized at #{int} would be {string}') do |int, string|
  expect(@asteroids.blasted(int).to_s).to eq(string)
end

Then('multiplied coords of the #{int}th vaporized would be {int}') do |int, int2|
  @blasted = @asteroids.blasted(int)
  expect(@blasted.x * 100 + @blasted.y).to eq(int2)
end
