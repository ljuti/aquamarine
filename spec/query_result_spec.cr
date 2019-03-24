require "./spec_helper"

module Aquamarine
  describe QueryResult do
    described_class = Aquamarine::QueryResult

    describe "Initialization" do
      it "can be instantiated" do
        subject = described_class.new
        subject.should be_a(Aquamarine::QueryResult)
      end
    end

    describe "#limit?" do
      it "returns true when results are limited" do

      end

      it "returns false when results aren't limited" do

      end
    end
  end
end