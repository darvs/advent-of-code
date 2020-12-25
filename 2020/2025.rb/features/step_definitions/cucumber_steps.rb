# frozen_string_literal: true

Given(/^the public keys in file "([^"]*)"$/) do |arg1|
  @filename = arg1
end

Then(/^the encryption key is (\d+)$/) do |arg1|
  expect(PublicKeys.from_file(@filename).encryption_key).to eq(arg1)
end
