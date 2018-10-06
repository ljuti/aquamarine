require "./spec_helper"

module Aquamarine
  describe Metadata do
    describe "default values" do

    end

    describe "allowed values" do
      data = Metadata.new
      data[:key] = "string"
      data[:key].should eq("string")
    end

    describe "#each" do
      data = Metadata.new
      data[:one] = "Foo"
      data[:two] = "Bar"
      # Test whether calling #each yields it to the data hash
    end
  end
end