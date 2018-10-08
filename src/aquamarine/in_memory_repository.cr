module Aquamarine
  class EventNotFoundError < Exception
  end

  class InMemoryRepository
    getter global
    getter streams

    def initialize
      @streams = Hash(Symbol | String | UUID, Array(Aquamarine::Event | Aquamarine::SerializedRecord)).new
      @mutex = Mutex.new
      @global = Array(Aquamarine::SerializedRecord).new
    end

    def read(query)
      events = query.stream.global? ? @global : stream_of(query.stream.name)
    end

    def stream_of(name)
      @streams.fetch(name, Array(Aquamarine::Event | Aquamarine::SerializedRecord).new)
    end

    def append_to_stream(event, stream)
      add_to_stream(event, stream, true)
    end

    def append_to_stream(events : Array(Aquamarine::SerializedRecord), stream)
      events.map do |event|
        add_to_stream(event, stream, true)
      end
    end

    def link_to_stream(event_ids : Array(UUID), stream)
      events = normalize_to_array(event_ids).map { |eid| read_event(eid) }
      add_to_stream(events, stream, true)
    end

    def add_to_stream(event, stream, include_global)
      normalized = normalize_to_array(event)
      append(normalized, stream, include_global)
    end

    def normalize_to_array(event)
      return *event
    end

    def append(event, include_global)
      if include_global
        @global.push(event)
      end
      self
    end

    def append(event, stream, include_global)
      event_stream = stream_of(stream.name)
      if include_global
        @global.push(event)
      end
      event_stream.push(event)
      @streams[stream.name] = event_stream
      self
    end

    def delete_stream(stream)
      @streams.delete(stream.name)
    end

    def read_event(event_id : UUID)
      result = @global.find {|event| event_id == event.event_id }
      raise EventNotFoundError.new("Event #{event_id} not found.") if result.nil?
      result
    end
  end

end