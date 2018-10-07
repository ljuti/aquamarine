require "uuid"
require "yaml"

module Aquamarine

  # Event is a data structure representing an event in the domain.
  struct Event
    abstract struct BaseData
      include YAML::Serializable

      property data : Hash(String, String | Float64)

      def initialize(input)
        @data = case input
        when .nil?
          {} of String => String | Float64
        when .is_a? Aquamarine::Event::Data
          input.data
        when .is_a? Aquamarine::Event::Metadata
          input.data
        else
          input.merge(Hash(String, String | Float64).new)
        end
      end

      def keys
        @data.keys
      end

      macro method_missing(call)
        @data.fetch({{call.name.id.stringify}})
      end
    end

    struct Data < BaseData
    end

    struct Metadata < BaseData
    end
    
    getter event_id : UUID
    getter data : Aquamarine::Event::Data
    getter metadata : Aquamarine::Event::Metadata
    getter event_type : String

    # Instantiates a new event.
    #
    # @param metadata [Hash] Event metadata that is not part of the domain
    # @param data [Hash] Event data that belongs to the application domain
    # @return [Event]
    def initialize(@event_id = UUID.random, data : (Hash(K, V), K -> V)? = nil, metadata : (Hash(K, V), K -> V)? = nil)
      @data = Aquamarine::Event::Data.new(data)
      @metadata = Aquamarine::Event::Metadata.new(metadata)
      @event_type = self.class.name
    end

    def initialize(
        @event_id = UUID.random,
        @data : Aquamarine::Event::Data = Aquamarine::Event::Data.new,
        @metadata : Aquamarine::Event::Metadata = Aquamarine::Event::Metadata.new
      )
      @event_type = self.class.name
    end

    def initialize(
        @event_id : UUID,
        data,
        metadata
      )
      @data = Aquamarine::Event::Data.new(data)
      @metadata = Aquamarine::Event::Metadata.new(metadata)
      @event_type = self.class.name
    end
    
    # Type of the event
    # @return [String]
    def type
      self.class.name
    end

    # Checks if given event is equal.
    # 
    # Two events are treated equal if:
    # * they are of the same event class
    # * they have identical event ID
    # * they have identical event data
    #
    # Event metadata is not taken into account in comparing two events.
    #
    # @param event [Event] Event object to compare
    # @return [Bool]
    def ==(event)
      event.class.name === self.class.name &&
        event.event_id === event_id &&
        event.data === data
    end
  end
end