# frozen_string_literal: true

Given('the input signal {string}') do |string|
  @fft = FFT.new(string)
end

Given('the input signal in {string}') do |string|
  @fft = FFT.from_file(string)
end

When('the signal is processed for {int} phases') do |int|
  @fft.run(int)
end

Then('the first {int} digits are {string}') do |int, string|
  expect(@fft.digits(int)).to eq(string)
end

Given('the input signal {string} repeated {int} times') do |string, int|
  @fft = FFT.new(string, int)
end

Then('the {int} digits at the check offset are {string}') do |int, string|
  expect(@fft.digits_with_offset(int)).to eq(string)
end
