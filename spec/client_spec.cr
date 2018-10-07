require "spec2"
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

    pending "returns self when an event is appended to a stream" do
      expect(client.append(TestEvent.new, stream_name: stream)).to eq(client)
    end

    pending "appends the event to the default stream if stream is not specified" do
      expect(client.append(test_event = TestEvent.new)).to eq(client)
      expect(client.read.all).to be_a(Array(Aquamarine::Event | Aquamarine::SerializedRecord))
      expect(client.read.all).to eq([test_event])
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

        pending "reads an event with specific ID from the repository" do
          expect(client.read_event(event.event_id)).to eq(event)
        end
      end
    end
  end
end