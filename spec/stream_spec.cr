require "spec2"

module Aquamarine
  Spec2.describe Stream do
    describe "Initializing streams" do
      it "initializes a new stream with given name" do
        stream_name = "stream with a name"
        stream = described_class.new(name: stream_name)
        expect(stream).to be_a(Aquamarine::Stream)
        expect(stream.name).to eq(stream_name)
      end

      it "raises error when stream name is empty" do
        expect_raises(ArgumentError) do
          described_class.new("")
        end
      end
    end

    describe "Global stream" do
      let(global) { described_class.new(GLOBAL_STREAM) }
      let(stream) { described_class.new("local") }

      describe "#global?" do
        it "returns true for a global stream" do
          expect(global.global?).to be_true
        end

        it "returns false for any other stream" do
          expect(stream.global?).to be_false
        end
      end
    end

    describe "Equality" do
      let(a_stream) { described_class.new("a-stream") }
      let(b_stream) { described_class.new("b-stream") }
      let(c_stream) { described_class.new("a-stream") }

      it "two streams with the same name are equal" do
        expect(a_stream).to eq(c_stream)
      end

      it "two streams with different names are not equal" do
        expect(a_stream).not_to eq(b_stream)
      end
    end
  end
end