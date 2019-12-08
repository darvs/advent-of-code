# frozen_string_literal: true

Given('the image in {string}') do |string|
  @filename = string
end

When('the image size is {int} x {int} pixels') do |int, int2|
  @img = Image.from_file(@filename, int, int2)
end

Then('on the layer with the least {int} the number of {int} digits multiplied by the number of {int} digits is {int}') do |int, int2, int3, int4|
  expect(@img.layer_with_least_first_multiply_second_third(int, int2, int3)).to eq(int4)
end

Then('show us the image') do
  @img.show
end
