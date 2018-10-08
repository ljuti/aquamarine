require "spec2"
require "../../src/aquamarine"
require "yaml"

module Aquamarine
  module Mappers
    Spec2.describe Default do
      let(event) { Aquamarine::Event.new }
      let!(event_id) { UUID.random }
      let(record) do
        Aquamarine::SerializedRecord.new(
          event_id: event_id,
          metadata: YAML.dump({ "data": {"meta": "data" }}),
          data: YAML.dump({ "data": { "foo": "bar" }}),
          event_type: "Aquamarine::Event"
        )
      end

      describe "Serialization" do
        describe "#event_to_serialized_record" do
          subject { described_class.new() }

          it "serializes an event" do
            expect(subject.event_to_serialized_record(event)).to be_a(Aquamarine::SerializedRecord)
          end
        end
      end

      describe "Deserialization" do
        describe "#serialized_record_to_event" do
          let(mapper) { described_class.new }
          let(event) do
            Aquamarine::Event.new(
              event_id: event_id,
              data: Aquamarine::Event::Data.new({ "foo" => "bar" }),
              metadata: Aquamarine::Event::Metadata.new({ "meta" => "data" })
            )
          end

          let(record2) do
            Aquamarine::SerializedRecord.new(
              event_id: event_id,
              data: "---\ndata:\n  foo: bar\n",
              metadata: "---\ndata:\n  meta: data\n",
              event_type: "Aquamarine::Event"
            )
          end

          subject { mapper.serialized_record_to_event(record) }

          it "deserializes a record to an event" do
            expect(subject).to eq(event)
            expect(subject.data.foo).to eq("bar")
            expect(subject.metadata.meta).to eq("data")

            obj = mapper.serialized_record_to_event(record2)
            expect(obj).to be_a(Aquamarine::Event)
            expect(obj.data.foo).to eq("bar")
            expect(obj.metadata.meta).to eq("data")
          end
        end
      end
    end
  end
end