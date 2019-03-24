require "./spec_helper"

module Aquamarine
  describe QueryReader do
    described_class = Aquamarine::QueryReader

    describe "Initialization" do
      repo = Aquamarine::InMemoryRepository.new
      mapper = Aquamarine::Mappers::Default.new

      it "can be instantiated" do
        subject = described_class.new(repo, mapper)
        subject.should be_a(Aquamarine::QueryReader)
      end
    end

    describe "Querying" do
      describe "#one" do
        
      end

      describe "#each" do
        
      end
    end
  end
end