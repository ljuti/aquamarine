require "./spec_helper"

module Aquamarine
  describe InMemoryRepository do
    described_class = Aquamarine::InMemoryRepository

    describe "Initializing the repository" do
      repo = described_class.new

      it "initializes correctly" do
        
      end
    end

    describe "#append" do
      repo = described_class.new
      stream = Aquamarine::Stream.new("river")

      describe "Global stream" do
        it "appends an event to the global stream" do
          event = Aquamarine::SerializedRecord.new(
            event_id: UUID.random,
            data: "",
            metadata: "",
            event_type: "Aquamarine::Event"
          )
    
          repo.append(event, stream, true).should eq(repo)
          repo.global.includes?(event).should be_true
        end
      end

      describe "Specific stream" do
        it "appends an event to a specific stream" do
          event = Aquamarine::SerializedRecord.new(
            event_id: UUID.random,
            data: "",
            metadata: "",
            event_type: "Aquamarine::Event"
          )
    
          repo.append(event, stream, true).should eq(repo)
          repo.streams[stream.name].includes?(event).should be_true
          repo.global.includes?(event).should be_true
        end

        it "appends an event to only a specific stream" do
          event = Aquamarine::SerializedRecord.new(
            event_id: UUID.random,
            data: "",
            metadata: "",
            event_type: "Aquamarine::Event"
          )
    
          repo.append(event, stream, false).should eq(repo)
          repo.streams[stream.name].includes?(event).should be_true
          repo.global.includes?(event).should be_false
        end
      end
    end

    describe "#read" do
      repo = described_class.new

      describe "Global stream" do
        # let(reader) { Aquamarine::QueryReader.new() }
        # let(result) { Aquamarine::QueryResult.new() }
        # let(query) { Aquamarine::Query.new() }

        it "reads events from global stream" do

        end
      end

      describe "Specific stream" do

      end
    end

    describe "#stream_of" do

    end

    describe "#read_event" do
      event = Aquamarine::Event.new
      record = Aquamarine::SerializedRecord.new(event_id: event.event_id,
        data: "",
        metadata: "",
        event_type: "Aquamarine::Event"
      )
      repo = described_class.new
      stream = Aquamarine::Stream.new("default")

      it "reads an event from the repository" do
        repo.append(record, stream, true)
        repo.read_event(event.event_id).should eq(record)
        typeof(repo.read_event(event.event_id)).should eq(Aquamarine::SerializedRecord)
      end

      it "raises an exception if an event with given UUID is not found" do
        # expect do
        #   repo.read_event(record.event_id)
        # end.to raise_error(EventNotFoundError)
      end
    end
  end
end