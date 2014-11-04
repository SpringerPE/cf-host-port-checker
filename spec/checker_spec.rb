require './app/server'

describe Checker do
  before(:each) do
    @checker = Checker.new
  end

  context 'TCP connection checker' do
    it "can find google.com" do
      check = @checker.port_open?("www.google.com", 80)
      expect(check).to eq(true)
    end

    it "can find example.com" do
      check = @checker.port_open?("www.example.com", 80)
      expect(check).to eq(true)
    end

    it "cannot find thisdomaindoesntexist.com" do
      check = @checker.port_open?("www.thisdomaindoesntexist.com", 80)
      expect(check).to eq(false)
    end
  end

  context 'URL existence checker' do
    it "can find google.com" do
      check = @checker.url_exists?("www.google.com")
      expect(check).to eq(true)
    end

    it "can find example.com" do
      check = @checker.url_exists?("http://www.example.com")
      expect(check).to eq(true)
    end

    it "cannot find thisdomaindoesntexist.com" do
      check = @checker.url_exists?("http://www.thisdomaindoesntexist.com/not/even/here")
      expect(check).to eq(false)
    end
  end
end