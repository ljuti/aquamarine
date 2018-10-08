require "spec2"
require "../src/aquamarine"

module Aquamarine
  Spec2.describe QueryResult do
    describe "Initialization" do
      subject { described_class.new }

      it "can be instantiated" do
        expect(subject).to be_a(Aquamarine::QueryResult)
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