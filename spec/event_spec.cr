require "./spec_helper"

module Aquamarine
  describe Event do
    it "instantiates a new event" do
      klass = Aquamarine::Event.new
      typeof(klass).should eq(Aquamarine::Event)
    end

    describe "properties" do
      it "has an ID" do
        event = Aquamarine::Event.new
        typeof(event.event_id).should eq(UUID)
      end

      it "has event type" do
        event = Aquamarine::Event.new
        event.type.should eq("Aquamarine::Event")
      end
    end
  end
end