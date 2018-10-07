require "spec2"
require "../../src/aquamarine"

module Aquamarine
  module Mappers
    Spec2.describe Default do
      let(event) { Aquamarine::Event.new }
      let(record) do
        Aquamarine::SerializedRecord.new(
          event_id: UUID.random,
          metadata: YAML.dump({ meta: "data" }),
          data: YAML.dump({ foo: "bar" }),
          event_type: "Aquamarine::Event"
        )
      end

      describe "Serialization" do
        describe "#event_to_serialized_record" do
          it "serializes an event" do

          end
        end
      end

      describe "Deserialization" do
        describe "#serialized_record_to_event" do
          let(mapper) { described_class.new }

          it "deserializes a record to an event" do
            # expect(mapper.serialized_record_to_event(record)).to eq(event)
            # mapper.serialized_record_to_event(record)
          end
        end
      end
    end
  end
end