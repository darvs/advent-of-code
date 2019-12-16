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
