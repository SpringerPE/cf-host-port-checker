require './app/server'

describe Checker do
  it "can find google.com" do
    checker = Checker.new
    check = checker.url_exists?("www.google.com", 80)
    expect(check).to eq(true)
  end

  it "can find example.com" do
    checker = Checker.new
    check = checker.url_exists?("www.example.com", 80)
    expect(check).to eq(true)
  end

  it "cannot find thisdomaindoesntexist.com" do
    checker = Checker.new
    check = checker.url_exists?("www.thisdomaindoesntexist.com", 80)
    expect(check).to eq(false)
  end
end