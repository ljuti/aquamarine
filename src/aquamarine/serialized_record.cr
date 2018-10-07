module Aquamarine
  struct SerializedRecord
    getter event_id
    getter data
    getter metadata
    getter event_type

    def initialize(event_id : UUID, data : String, metadata : String, event_type : String)
      @event_id = event_id
      @data     = data
      @metadata = metadata
      @event_type = event_type
    end

  end
end