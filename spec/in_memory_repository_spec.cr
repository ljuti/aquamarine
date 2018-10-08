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
      let(event) { Aquamarine::SerializedRecord.new(
        event_id: UUID.random,
        data: "",
        metadata: "",
        event_type: "Aquamarine::Event"
      ) }
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

    describe "#read_event" do
      let(event) { Aquamarine::Event.new }
      let(record) do
        Aquamarine::SerializedRecord.new(event_id: event.event_id,
          data: "",
          metadata: "",
          event_type: "Aquamarine::Event"
        )
      end
      let(repo) { described_class.new }
      let(stream) { Aquamarine::Stream.new("default") }

      subject { repo.read_event(event.event_id) }

      it "reads an event from the repository" do
        repo.append(record, stream, true)
        expect(subject).to eq(record)
        expect(typeof(subject)).to eq(Aquamarine::SerializedRecord)
      end

      it "raises an exception if an event with given UUID is not found" do
        expect do
          repo.read_event(record.event_id)
        end.to raise_error(EventNotFoundError)
      end
    end
  end
end