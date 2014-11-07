require './app/server'
require 'spec_helper'

describe Checker do
  before(:each) do
    @checker = Checker.new
  end

  context 'TCP connection checker' do
    it "can find google.com" do
      Checker.stub(:coonect_to_socket).and_return(true)
      check = @checker.port_open?("www.google.com", 80)
      expect(check).to eq(true)
    end

    it "cannot find thisdomaindoesntexist.com" do
      Checker.stub(:coonect_to_socket).and_return(false)
      check = @checker.port_open?("www.thisdomaindoesntexist.com", 80)
      expect(check).to eq(false)
    end
  end

  context 'URL existence checker' do

    it "can find google.com" do
      check = @checker.url_exists?("www.google.com")
      expect(check).to eq(true)
    end

    it "cannot find http://www.google.com/images/cannotbefound" do
      check = @checker.url_exists?("http://www.google.com/images/cannotbefound")
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