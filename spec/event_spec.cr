require "./spec_helper"
require "../src/aquamarine"

module Aquamarine
  describe Event do
    it "instantiates a new event" do
      klass = Aquamarine::Event.new()
      typeof(klass).should eq(Aquamarine::Event)
    end

    describe "Properties" do
      it "has an ID" do
        event = Aquamarine::Event.new()
        typeof(event.event_id).should eq(UUID)
      end

      it "has event type" do
        event = Aquamarine::Event.new()
        event.type.should eq("Aquamarine::Event")
      end

      it "has a data object" do
        event = Aquamarine::Event.new()
        typeof(event.data).should eq(Aquamarine::Event::Data)
      end
    end

    describe "Event data" do
      data_hash = {
        "name" => "gold",
        "hardness" => 2.5
      }

      describe "#keys" do
        data = Aquamarine::Event::Data.new(data_hash)

        it "returns the keys of the data object" do
          data.keys.should eq(["name", "hardness"])
        end
      end

      describe "from an Event::Data object" do
        it "creates a new event data object from existing object" do
          obj = Aquamarine::Event::Data.new(data_hash)
          obj2 = Aquamarine::Event::Data.new(obj)
          obj2.should be_a(Aquamarine::Event::Data)
          obj2.name.should eq("gold")
        end
      end

      describe "from a hash" do
        it "creates an event data object from a hash" do
          obj = Aquamarine::Event::Data.new(data_hash)
          typeof(obj).should eq(Aquamarine::Event::Data)
          obj.name.should eq("gold")
          obj.hardness.should eq(2.5)
        end

        # it "can also be an empty hash" do
        #   data = {} of String => String | Float64
        #   obj = Aquamarine::Event::Data.new(data)
        #   expect do
        #     obj.foo
        #   end.to raise_error(KeyError)  
        # end
      end
    end
  end
end