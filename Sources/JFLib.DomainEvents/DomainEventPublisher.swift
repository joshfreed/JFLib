import Foundation

public class DomainEventPublisher {
    public static let shared = DomainEventPublisher()

    private var singleSubscribers: [DomainEventSubscriberProto] = []
    private var permanentSubscribers: [DomainEventSubscriberProto] = []
    private var allEventSubscribers: [AnyDomainEventHandler] = []
    private var pendingHandlers: [() -> Void] = []

    /// Immediately publishes the given `DomainEvent` to subscribers.
    public func publish<T: DomainEvent>(_ domainEvent: T) {
        (singleSubscribers + permanentSubscribers)
            .filter { $0.eventType == T.self }
            .forEach { $0.handleEvent(domainEvent) }
        allEventSubscribers.forEach { $0.handleEvent(domainEvent) }
    }

    /// Adds a `DomainEvent` that will be published later. Call `publishPendingEvents` to immediately publish all added events.
    ///
    /// Use this method when you want domain events to only be published if a transaction succeeds, for example saving to a database.
    public func add<T: DomainEvent>(_ domainEvent: T) {
        pendingHandlers = (singleSubscribers + permanentSubscribers)
            .filter { $0.eventType == T.self }
            .map { subscriber in { subscriber.handleEvent(domainEvent) } }
        pendingHandlers += allEventSubscribers.map { subscriber in { subscriber.handleEvent(domainEvent) } }
    }

    /// Immediately publishes domain events added by the `add` method. Once published, the domain events are cleared.
    public func publishPendingEvents() {
        for handler in pendingHandlers {
            handler()
        }
        pendingHandlers = []
        singleSubscribers = []
    }

    /// Attach a subscriber that will be fired when a domain event matching the specified type is published.
    public func subscribe<T: DomainEvent>(_ subscriber: DomainEventSubscriber<T>) {
        singleSubscribers.append(subscriber)
    }

    /// Attach a subscriber that will be fired when a domain event matching the specified type is published.
    public func subscribe<T: DomainEvent>(_ subscriber: DomainEventHandler<T>) {
        permanentSubscribers.append(subscriber)
    }

    /// Attach a subscriber that will be fired when any domain event is published.
    public func subscribe(_ subscriber: AnyDomainEventHandler) {
        allEventSubscribers.append(subscriber)
    }

    /// Clears all subscribers. Subscribers will remain attached forever unless this func is called.
    public func reset() {
        singleSubscribers = []
    }
}
