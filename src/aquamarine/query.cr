module Aquamarine
  class Query
    include Enumerable(Aquamarine::Event)

    DEFAULT_BATCH_SIZE = 100
    
    getter result

    def initialize(@reader : Aquamarine::QueryReader, @result = Aquamarine::QueryResult.new)
    end

    def each
      each { }      
    end

    def each(&block)
      each_batch do |batch|
        batch.each { |event| yield event }
      end
    end

    def each_batch
      each_batch { }
    end

    def each_batch(&block)
      @reader.each(in_batches(@result.batch_size).result) do |batch|
        yield batch
      end
    end

    def all
      @reader.all
    end

    def in_batches(size : Int32)
      result = @result.dup
      result.read_as = :batch
      result.batch_size = size
      Query.new(@reader, result)
    end
  end
end