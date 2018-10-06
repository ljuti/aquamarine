require "uuid"

module Aquamarine

  # Event is a data structure representing an event in the domain.
  class Event
    getter event_id : UUID
    getter data

    # Instantiates a new event.
    #
    # @param metadata [String] Event metadata that is not part of the domain
    # @param data [Tuple] Event data that belongs to the application domain
    # @return [Event]
    def initialize(@event_id = UUID.random)
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
      event.instance_of?(self.class) &&
        event.event_id.eql?(event_id) &&
        event.data.eql?(data)
    end
  end
end