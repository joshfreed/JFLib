import XCTest
import JFLib_DomainEvents

class DomainEventPublishingTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
        DomainEventPublisher.shared.reset()
    }

    func test_publish_once_single_subscriber() {
        var events: [TestEvent1] = []
        DomainEventPublisher.shared.subscribe(DomainEventSubscriber<TestEvent1> { domainEvent in
            events.append(domainEvent)
        })

        DomainEventPublisher.shared.publish(TestEvent1(id: 1))

        XCTAssertEqual(1, events.count)
        XCTAssertEqual(1, events[0].id)
    }

    func test_publish_twice_single_subscriber() {
        var events: [TestEvent1] = []
        DomainEventPublisher.shared.subscribe(DomainEventSubscriber<TestEvent1> { domainEvent in
            events.append(domainEvent)
        })

        DomainEventPublisher.shared.publish(TestEvent1(id: 1))
        DomainEventPublisher.shared.publish(TestEvent1(id: 2))

        XCTAssertEqual(2, events.count)
        XCTAssertEqual(1, events[0].id)
        XCTAssertEqual(2, events[1].id)
    }

    func test_delayed_publish() {
        var events: [TestEvent1] = []
        DomainEventPublisher.shared.subscribe(DomainEventSubscriber<TestEvent1> { domainEvent in
            events.append(domainEvent)
        })

        DomainEventPublisher.shared.add(TestEvent1(id: 1))

        XCTAssertEqual(0, events.count)

        DomainEventPublisher.shared.publishPendingEvents()

        XCTAssertEqual(1, events.count)
        XCTAssertEqual(1, events[0].id)

        DomainEventPublisher.shared.publishPendingEvents()

        XCTAssertEqual(1, events.count)
    }

    func test_handler_class() {
        let handler = TestEventOneHandler()
        DomainEventPublisher.shared.subscribe(handler)

        DomainEventPublisher.shared.publish(TestEvent1(id: 1))

        XCTAssertEqual(1, handler.events.count)
        XCTAssertEqual(1, handler.events[0].id)
    }

    func test_handler_for_all_events() {
        let handler = AllEventsHandler()
        DomainEventPublisher.shared.subscribe(handler)

        DomainEventPublisher.shared.publish(TestEvent1(id: 1))
        DomainEventPublisher.shared.publish(TestEvent2(id: 2))

        XCTAssertEqual(2, handler.events.count)
        XCTAssertEqual(1, (handler.events[0] as? TestEvent1)?.id)
        XCTAssertEqual(2, (handler.events[1] as? TestEvent2)?.id)
    }
}

struct TestEvent1: DomainEvent {
    let id: Int
}

struct TestEvent2: DomainEvent {
    let id: Int
}

class TestEventOneHandler: DomainEventHandler<TestEvent1> {
    var events: [TestEvent1] = []

    override func handle(event: TestEvent1) {
        events.append(event)
    }
}

class AllEventsHandler: AnyDomainEventHandler {
    var events: [DomainEvent] = []

    func handleEvent(_ event: DomainEvent) {
        events.append(event)
    }
}
