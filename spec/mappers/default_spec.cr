require "../spec_helper"
require "yaml"

module Aquamarine
  module Mappers
    describe Default do
      described_class = Aquamarine::Mappers::Default

      event = Aquamarine::Event.new
      event_id = UUID.random
      record = Aquamarine::SerializedRecord.new(
        event_id: event_id,
        metadata: YAML.dump({ "data": {"meta": "data" }}),
        data: YAML.dump({ "data": { "foo": "bar" }}),
        event_type: "Aquamarine::Event"
      )

      describe "Serialization" do
        describe "#event_to_serialized_record" do
          mapper = described_class.new()

          it "serializes an event" do
            mapper.event_to_serialized_record(event).should be_a(Aquamarine::SerializedRecord)
          end
        end
      end

      describe "Deserialization" do
        describe "#serialized_record_to_event" do
          mapper = described_class.new
          event = Aquamarine::Event.new(
            event_id: event_id,
            data: Aquamarine::Event::Data.new({ "foo" => "bar" }),
            metadata: Aquamarine::Event::Metadata.new({ "meta" => "data" })
          )

          record2 = Aquamarine::SerializedRecord.new(
            event_id: event_id,
            data: "---\ndata:\n  foo: bar\n",
            metadata: "---\ndata:\n  meta: data\n",
            event_type: "Aquamarine::Event"
          )
        
          it "deserializes a record to an event" do
            subject = mapper.serialized_record_to_event(record)
            subject.should eq(event)
            subject.data.foo.should eq("bar")
            subject.metadata.meta.should eq("data")

            obj = mapper.serialized_record_to_event(record2)
            obj.should be_a(Aquamarine::Event)
            obj.data.foo.should eq("bar")
            obj.metadata.meta.should eq("data")
          end
        end
      end
    end
  end
end