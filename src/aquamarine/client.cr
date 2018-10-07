module Aquamarine
  GLOBAL_STREAM = "global"

  class Client
    getter mapper

    def initialize(@repository : Aquamarine::InMemoryRepository)
      @mapper = Mappers::Default.new
    end
    
    def publish(event : Aquamarine::Event)
      self
    end

    def append(event : Aquamarine::Event, stream_name : (String)? = GLOBAL_STREAM)
      serialized = serialize_event(event)
      append_serialized_to_stream(serialized, stream_name: stream_name)
      self
    end

    def read()
      Query.new(QueryReader.new(@repository))
    end

    def read_event(event_id)
      deserialize_event(@repository.read_event(event_id))
    end

    def delete_stream(name)
      @repository.delete_stream(Stream.new(name: name))
      self
    end

    private def serialize_event(event : Aquamarine::Event)
      @mapper.event_to_serialized_record(event)
    end

    private def deserialize_event(record : Aquamarine::SerializedRecord | Aquamarine::Event)
      @mapper.serialized_record_to_event(record)
    end

    private def append_serialized_to_stream(event : Aquamarine::SerializedRecord, stream_name : String)
      @repository.append_to_stream(event, Stream.new(stream_name))
    end
  end

end