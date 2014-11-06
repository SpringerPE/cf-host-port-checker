Given /^I am viewing "(.+)"$/ do |url|
  visit(url)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |element, text|
  fill_in element, with: text
end

When /^I click "([^"]*)"$/ do |element|
  click_button element
  follow_redirect!
end

Then /^I should see "(.+)"$/ do |text|
  expect(response_body).to match Regexp.new(Regexp.escape(text))
end


Then(/^I should be on "(.*?)"$/) do |url|
  expect(path).to eq(url)
end
