module Aquamarine

  struct Stream
    getter name

    def initialize(@name : String)
      raise ArgumentError.new("Error creating a stream with given name") if !(name === GLOBAL_STREAM) && !valid_name?(name)
      @name = name
    end

    def global?
      @name === GLOBAL_STREAM
    end

    private def valid_name?(name)
      !name.empty?
    end
  end

end