require "./base_mapper"
require "yaml"

module Aquamarine
  module Mappers
    class Default < BaseMapper

      def initialize(serializer = YAML)
        @serializer = serializer
      end

      def event_to_serialized_record(event : Aquamarine::Event)
        SerializedRecord.new(
          event_id: event.event_id,
          metadata: @serializer.dump(event.metadata),
          data: @serializer.dump(event.data),
          event_type: event.type
        )
      end

      def serialized_record_to_event(record : Aquamarine::Event | Aquamarine::SerializedRecord)
        Aquamarine::Event.new(
          event_id: record.event_id,
          data: Aquamarine::Event::Data.from_yaml(record.data),
          metadata: Aquamarine::Event::Metadata.from_yaml(record.metadata)
        )
      end
    end
  end
end