require "./spec_helper"

module Aquamarine
  describe Query do
    described_class = Aquamarine::Query
    
    describe "Initializing a query" do
      mapper = Aquamarine::Mappers::Default.new()
      reader = Aquamarine::QueryReader.new(Aquamarine::InMemoryRepository.new(), mapper)
      result = Aquamarine::QueryResult.new()

      it "will initialize when given proper arguments" do
        query = described_class.new(reader, result)
        query.should be_a(Aquamarine::Query)
      end
    end

    describe "Scoping query to a stream" do
      
    end
  end
end