module Aquamarine
  class QueryResult
    property batch_size : Int32
    property read_as : Symbol
    getter stream

    def initialize(direction = :forward,
        stream = Aquamarine::Stream.new(GLOBAL_STREAM)
      )
      @batch_size = 100
      @read_as = :all
      @stream = stream
    end
  end
end