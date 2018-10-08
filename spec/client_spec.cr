require "spec2"
require "spec2-mocks"
require "../src/aquamarine"
require "uuid"

TestEvent = Aquamarine::Event

module Aquamarine
  Spec2.describe Client do
    let(client) { Aquamarine::Client.new(repository: Aquamarine::InMemoryRepository.new) }
    let(stream) { UUID.random.to_s }

    it "returns self when an event is successfully published" do
      expect(client.publish(TestEvent.new)).to eq(client)
    end

    describe "Appending events" do
      describe "- a single event" do
        it "returns self when an event is appended to a stream" do
          expect(client.append(TestEvent.new, stream_name: stream)).to eq(client)
        end
  
        it "appends events to global stream" do
          expect(client.append(TestEvent.new)).to eq(client)
          # expect(client.read.all.includes?(test_event)).to be_true
        end  
      end

      describe "- multiple events" do
        it "returns self when multiple events have been appended" do
          expect(client.append([TestEvent.new, TestEvent.new])).to eq(client)
        end
      end
    end

    pending "appends the event to the default stream if stream is not specified" do
      expect(client.append(test_event = TestEvent.new)).to eq(client)
      expect(client.read.all).to be_a(Array(Aquamarine::Event))
      expect(client.read.all).to eq([test_event])
    end

    describe "Linking" do
      describe "#link" do
        let!(event1) { Aquamarine::Event.new }
        let!(event2) { Aquamarine::Event.new }
        let!(stream1) { Aquamarine::Stream.new("first") }
        let!(stream2) { Aquamarine::Stream.new("second") }
        let(repo) { Aquamarine::InMemoryRepository.new }
        let(client) { described_class.new(repo) }

        before do
          client.append([event1, event2], "first")
        end

        it "links already persisted events to a different stream" do
          expect(repo.global.size).to eq(2)
          # TODO: Implement how to verify that the link exists
        end
      end
    end

    describe "Streams" do
      describe "#delete_stream(name)" do
        let(repository) { Aquamarine::InMemoryRepository.new }
        let(client) { described_class.new(repository: repository) }

        it "deletes a stream with given name from the repository" do
          expect(client.delete_stream("gushing-river")).to eq(client)
          expect(repository.streams.includes?("gushing-river")).to be_false
        end
      end
    end

    describe "Reading events" do
      describe "#read_event(event_id)" do
        let(event) { Aquamarine::Event.new }
        let(repository) { Aquamarine::InMemoryRepository.new }
        let(client) { described_class.new(repository: repository) }

        it "reads an event with specific ID from the repository" do
          client.append(event)
          expect(client.read_event(event.event_id)).to eq(event)
        end
      end
    end
  end
end