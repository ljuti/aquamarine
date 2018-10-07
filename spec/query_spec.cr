require "spec2"

module Aquamarine

  Spec2.describe Query do
    describe "Initializing a query" do
      let(reader) { Aquamarine::QueryReader.new(Aquamarine::InMemoryRepository.new()) }
      let(result) { Aquamarine::QueryResult.new() }

      it "will initialize when given proper arguments" do
        query = described_class.new(reader, result)
        expect(query).to be_true
      end
    end

    
  end

end