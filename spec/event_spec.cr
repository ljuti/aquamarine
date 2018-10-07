require "spec2"
require "../src/aquamarine"

module Aquamarine
  Spec2.describe Event do
    it "instantiates a new event" do
      klass = Aquamarine::Event.new()
      expect(typeof(klass)).to eq(Aquamarine::Event)
    end

    describe "Properties" do
      it "has an ID" do
        event = Aquamarine::Event.new()
        expect(typeof(event.event_id)).to eq(UUID)
      end

      it "has event type" do
        event = Aquamarine::Event.new()
        expect(event.type).to eq("Aquamarine::Event")
      end

      it "has a data object" do
        event = Aquamarine::Event.new()
        expect(typeof(event.data)).to eq(Aquamarine::Event::Data)
      end
    end

    describe "Event data" do
      let(data_hash) do
        {
          "name" => "gold",
          "hardness" => 2.5
        }
      end

      describe "#keys" do
        let(data) { Aquamarine::Event::Data.new(data_hash) }

        it "returns the keys of the data object" do
          expect(data.keys).to eq(["name", "hardness"])
        end
      end

      describe "from an Event::Data object" do
        it "creates a new event data object from existing object" do
          obj = Aquamarine::Event::Data.new(data_hash)
          obj2 = Aquamarine::Event::Data.new(obj)
          expect(obj2).to be_a(Aquamarine::Event::Data)
          expect(obj2.name).to eq("gold")
        end
      end

      describe "from a hash" do
        it "creates an event data object from a hash" do
          obj = Aquamarine::Event::Data.new(data_hash)
          expect(typeof(obj)).to eq(Aquamarine::Event::Data)
          expect(obj.name).to eq("gold")
          expect(obj.hardness).to eq(2.5)
        end

        it "can also be an empty hash" do
          data = {} of String => String | Float64
          obj = Aquamarine::Event::Data.new(data)
          expect do
            obj.foo
          end.to raise_error(KeyError)  
        end
      end
    end
  end
end