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
          # metadata: @serializer.dump(event.metadata),
          metadata: "metadata-string",
          data: @serializer.dump(event.data),
          event_type: event.type
        )
      end

      def serialized_record_to_event(record : Aquamarine::Event | Aquamarine::SerializedRecord)
        # Aquamarine::Event.new(
        #   event_id: record.event_id,
        #   metadata: Metadata.new(@serializer.parse(record.metadata).as_h),
        #   data: @serializer.parse(record.data).as_h
        # )
        Aquamarine::Event.new
      end
    end
  end
end