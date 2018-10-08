module Aquamarine
  class QueryResult
    property batch_size : Int32
    property read_as : Symbol
    getter stream

    def initialize(@direction = :forward,
        @start = :head,
        @count : Int32? = nil,
        @stream = Aquamarine::Stream.new(GLOBAL_STREAM),
        @read_as = :all,
        @batch_size = Query::DEFAULT_BATCH_SIZE
      )
    end
  end
end