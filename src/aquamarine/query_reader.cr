module Aquamarine
  class QueryReader
    getter repository
    getter mapper

    def initialize(@repository : Aquamarine::InMemoryRepository, @mapper : Aquamarine::Mappers::Default)
    end

    def one(query_result)
      record = repository.read(query_result)
      mapper.serialized_record_to_event(record) if record
    end

    def each(query_result)
      repository.read(query_result).each do |batch|
        yield batch.map { |serialized_record| mapper.serialized_record_to_event(serialized_record) }
      end
    end

    def has_event?(event_id)
      repository.has_event?(event_id)
    end

    def all
      repository.read(QueryResult.new)
    end
  end
end