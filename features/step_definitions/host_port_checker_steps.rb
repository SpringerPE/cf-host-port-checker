Given /^I am viewing "(.+)"$/ do |url|
  visit(url)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |element, text|
  fill_in element, with: text
end

When /^I click "Check url"$/ do
  do_stubbing
  click_button "Check url"
  follow_redirect!
end

When /^I click "Check tcp"$/ do
  server = TCPServer.new 6667
  click_button "Check tcp"
  follow_redirect!
  server.close
end

Then /^I should see "(.+)"$/ do |text|
  expect(response_body).to match Regexp.new(Regexp.escape(text))
end

Then(/^I should be on "(.*?)"$/) do |url|
  expect(path).to eq(url)
end

def do_stubbing
  stub_request(:get, "http://www.google.com/").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "", :headers => {})
  stub_request(:get, "http://www.domaindoesnotexist.com/").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_raise("Could not resolve host: www.domaindoesnotexist.com")
end