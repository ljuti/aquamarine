require "spec2"
require "../src/aquamarine"

module Aquamarine
  Spec2.describe QueryReader do
    describe "Initialization" do
      let(repo) { Aquamarine::InMemoryRepository.new }
      let(mapper) { Aquamarine::Mappers::Default.new }

      subject { described_class.new(repo, mapper) }
      
      it "can be instantiated" do
        expect(subject).to be_a(Aquamarine::QueryReader)
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