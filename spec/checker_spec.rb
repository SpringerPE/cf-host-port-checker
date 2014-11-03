require './app/server'

describe Checker do
  it "can find google" do
    checker = Checker.new
    check = checker.url_exists?("www.google.com", 80)
    expect(check).to eq(true)
  end

  it "can find example.com" do
    checker = Checker.new
    check = checker.url_exists?("www.example.com", 80)
    expect(check).to eq(true)
  end
end