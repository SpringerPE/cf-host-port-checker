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
    it "can find springer.com" do
      check = @checker.url_exists?("www.springer.com")
      expect(check).to eq(true)
    end

    it "can find google.com" do
      check = @checker.url_exists?("www.google.com")
      expect(check).to eq(true)
    end

    it "can find example.com" do
      check = @checker.url_exists?("http://www.example.com")
      expect(check).to eq(true)
    end

    it "cannot find http://www.google.com/images/sometjwe (404)" do
      check = @checker.url_exists?("http://www.google.com/images/sometjwe")
      expect(check).to eq(false)
    end

    it "cannot find thisdomaindoesntexist.com" do
      check = @checker.url_exists?("http://www.thisdomaindoesntexist.com/not/even/here")
      expect(check).to eq(false)
    end
  end

  context "error log" do
    it "knows about errors in urls" do
      @checker.url_exists?("http://www.thisdomaindoesntexist.com/not/even/here")
      expect(@checker.errors).to_not be_empty
    end

    it "knows about errors in tcp" do
      @checker.port_open?("www.thisdomaindoesntexist.com", 80)
      expect(@checker.errors).to_not be_empty
    end
  end

end