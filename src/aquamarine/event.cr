require "uuid"

module Aquamarine

  # Event is a data structure representing an event in the domain.
  struct Event
    getter event_id : UUID
    getter data : Hash(Symbol, Int32 | String)
    getter metadata : Aquamarine::Metadata
    getter event_type : String

    # Instantiates a new event.
    #
    # @param metadata [Hash] Event metadata that is not part of the domain
    # @param data [Hash] Event data that belongs to the application domain
    # @return [Event]
    def initialize(@event_id = UUID.random, metadata : (Hash(K, V), K -> V)? = nil, data : (Hash(K, V), K -> V)? = nil)
      @metadata = Metadata.new(processed_metadata(metadata))
      @data = processed_data(data)
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

    def processed_metadata(input)
      return Hash(Symbol, Int32 | String).new if input.nil?
      return input.to_h
    end

    def processed_data(input)
      return Hash(Symbol, Int32 | String).new if input.nil?
      return input.to_h
    end
  end
end