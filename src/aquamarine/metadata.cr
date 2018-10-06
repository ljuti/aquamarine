module Aquamarine
  class Metadata
    def initialize()
      @data = Hash(Symbol, Int32 | String).new
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      raise ArgumentError.new("You supplied data that is not of valid type.") unless allowed_types.any?{ |klass| klass === value }
      raise ArgumentError.new("The key for metadata should be a symbol.") unless typeof(key) == Symbol
      @data[key] = value
    end

    def each(&block)
      @data.each(&block)
    end

    def allowed_types
      [
        Int32,
        String
      ]
    end
  end
end