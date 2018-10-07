module Aquamarine

  # Metadata is a data structure for storing domain event related metadata.
  class Metadata

    # Instantiates a new metadata object.
    def initialize(@data = self)
      @data = Hash(Symbol, Int32 | String).new
    end

    # Data structure query method. Works just like a hash.
    #
    # @param key [Symbol] Key
    # @return [] Value stored to given key
    def [](key : Symbol)
      @data[key]
    end

    # Sets a value under a given key.
    #
    # @param key [Symbol] Key
    # @param value [] Value to be stored to given key
    def []=(key, value)
      raise ArgumentError.new("You supplied data that is not of valid type.") unless allowed_types.any?{ |klass| klass === value }
      raise ArgumentError.new("The key for metadata should be a symbol.") unless typeof(key) == Symbol
      @data[key] = value
    end

    # Enumerates the given block over the data structure elements.
    #
    # @param &block [Proc] Block to execute
    def each(&block)
      @data.each(&block)
    end

    # Allowed data types for the data structure values.
    def allowed_types
      [
        Int32,
        String
      ]
    end

    def to_yaml(builder : YAML::Nodes::Builder)
      nil
    end
  end
end