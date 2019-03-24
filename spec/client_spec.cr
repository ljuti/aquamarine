require "./spec_helper"
require "uuid"

TestEvent = Aquamarine::Event

module Aquamarine
  described_class = Aquamarine::Client

  describe Client do
    client = Aquamarine::Client.new(repository: Aquamarine::InMemoryRepository.new)
    stream = UUID.random.to_s

    it "returns self when an event is successfully published" do
      client.publish(TestEvent.new).should eq(client)
    end

    describe "Appending events" do
      describe "- a single event" do
        it "returns self when an event is appended to a stream" do
          client.append(TestEvent.new, stream_name: stream).should eq(client)
        end
  
        it "appends events to global stream" do
          client.append(TestEvent.new).should eq(client)
          # expect(client.read.all.includes?(test_event)).to be_true
        end  
      end

      describe "- multiple events" do
        it "returns self when multiple events have been appended" do
          client.append([TestEvent.new, TestEvent.new]).should eq(client)
        end
      end
    end

    pending "appends the event to the default stream if stream is not specified" do
      client.append(test_event = TestEvent.new).should eq(client)
      client.read.all.should be_a(Array(Aquamarine::Event))
      client.read.all.should eq([test_event])
    end

    describe "Linking" do
      describe "#link" do
        event1 = Aquamarine::Event.new
        event2 = Aquamarine::Event.new
        stream1 = Aquamarine::Stream.new("first")
        stream2 = Aquamarine::Stream.new("second")
        repo = Aquamarine::InMemoryRepository.new
        client = described_class.new(repo)

        it "links already persisted events to a different stream" do
          client.append([event1, event2], "first")
          repo.global.size.should eq(2)
          # TODO: Implement how to verify that the link exists
        end
      end
    end

    describe "Streams" do
      describe "#delete_stream(name)" do
        repository = Aquamarine::InMemoryRepository.new
        client = described_class.new(repository: repository)

        it "deletes a stream with given name from the repository" do
          client.delete_stream("gushing-river").should eq(client)
          repository.streams.includes?("gushing-river").should be_false
        end
      end
    end

    describe "Reading events" do
      describe "#read_event(event_id)" do
        event = Aquamarine::Event.new
        repository = Aquamarine::InMemoryRepository.new
        client = described_class.new(repository: repository)

        it "reads an event with specific ID from the repository" do
          client.append(event)
          client.read_event(event.event_id).should eq(event)
        end
      end
    end
  end
end