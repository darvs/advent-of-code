# frozen_string_literal: true

Given('the content of file {string}') do |arg1|
  @distress_signal = DistressSignal.from_file(arg1)
end

Then(/^the sum of the indices of the pairs in order is (\d+)$/) do |arg1|
  expect(@distress_signal.run).to eq(arg1)
end

Then(/^the decoder key is (\d+)$/) do |arg1|
  expect(@distress_signal.decoder_key).to eq(arg1)
end
