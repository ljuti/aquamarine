require "spec2"
require "../src/aquamarine"

module Aquamarine
  Spec2.describe InMemoryRepository do
    describe "Initializing the repository" do
      let(repo) { described_class.new }

      it "initializes correctly" do
        
      end
    end

    describe "#append" do
      let(repo) { described_class.new }
      let(event) { Aquamarine::Event.new }
      let(stream) { Aquamarine::Stream.new("river") }

      context "Global stream" do
        it "appends an event to the global stream" do
          expect(repo.append(event, stream, true)).to eq(repo)
          expect(repo.global.includes?(event)).to be_true
        end
      end

      context "Specific stream" do
        it "appends an event to a specific stream" do
          expect(repo.append(event, stream, true)).to eq(repo)
          expect(repo.streams[stream.name].includes?(event)).to be_true
          expect(repo.global.includes?(event)).to be_true
        end

        it "appends an event to only a specific stream" do
          expect(repo.append(event, stream, false)).to eq(repo)
          expect(repo.streams[stream.name].includes?(event)).to be_true
          expect(repo.global.includes?(event)).to be_false
        end
      end
    end

    describe "#read" do
      let(repo) { described_class.new }

      context "Global stream" do
        # let(reader) { Aquamarine::QueryReader.new() }
        # let(result) { Aquamarine::QueryResult.new() }
        # let(query) { Aquamarine::Query.new() }

        it "reads events from global stream" do

        end
      end

      context "Specific stream" do

      end
    end

    describe "#stream_of" do

    end
  end
end