require "./spec_helper"

module Aquamarine
  describe Stream do
    described_class = Aquamarine::Stream

    describe "Initializing streams" do
      it "initializes a new stream with given name" do
        stream_name = "stream with a name"
        stream = described_class.new(name: stream_name)
        stream.should be_a(Aquamarine::Stream)
        stream.name.should eq(stream_name)
      end

      it "raises error when stream name is empty" do
        expect_raises(ArgumentError) do
          described_class.new("")
        end
      end
    end

    describe "Global stream" do
      global = described_class.new(GLOBAL_STREAM)
      stream = described_class.new("local")

      describe "#global?" do
        it "returns true for a global stream" do
          global.global?.should be_true
        end

        it "returns false for any other stream" do
          stream.global?.should be_false
        end
      end
    end

    describe "Equality" do
      a_stream = described_class.new("a-stream")
      b_stream = described_class.new("b-stream")
      c_stream = described_class.new("a-stream")

      it "two streams with the same name are equal" do
        a_stream.should eq(c_stream)
      end

      it "two streams with different names are not equal" do
        a_stream.should_not eq(b_stream)
      end
    end
  end
end