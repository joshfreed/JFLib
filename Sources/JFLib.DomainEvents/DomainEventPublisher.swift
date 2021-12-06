import Foundation

public class DomainEventPublisher {
    public static let shared = DomainEventPublisher()

    private var subscribers: [DomainEventSubscriberProto] = []

    public func publish<T: DomainEvent>(_ domainEvent: T) {
        subscribers
            .filter { $0.eventType == T.self }
            .forEach { $0.handleEvent(domainEvent) }
    }

    public func subscribe<T: DomainEvent>(_ subscriber: DomainEventSubscriber<T>) {
        subscribers.append(subscriber)
    }

    public func reset() {
        subscribers = []
    }
}
