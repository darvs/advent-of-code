# frozen_string_literal: true

Given(/^the target area in file "([^"]*)"$/) do |arg1|
  @shooter = Shooter.from_file(arg1).run
end

Then(/^it can reach a y value of (\d+) at its apex$/) do |arg1|
  expect(@shooter.apex_val).to eq(arg1)
end

Then(/^it hits the target (\d+) times$/) do |arg1|
  expect(@shooter.hit_count).to eq(arg1)
end
