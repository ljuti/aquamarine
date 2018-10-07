module Aquamarine
  class QueryReader

    def initialize(@repository : Aquamarine::InMemoryRepository)
    end

    def one(query_result)
    end

    def each(query_result)
      @repository.read(query_result).each do |batch|
        yield batch.map { |serialized_record| mapper.serialized_record_to_event(serialized_record) }
      end
    end

    def all
      @repository.read(QueryResult.new)
    end
  end
end