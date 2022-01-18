import Foundation

protocol DomainEventSubscriberProto {
    var eventType: DomainEvent.Type { get }
    func handleEvent(_ domainEvent: DomainEvent)
}

public class DomainEventSubscriber<T: DomainEvent>: DomainEventSubscriberProto {
    /// The aciton to execute when an event is received
    let handlerAction: (T) -> Void

    /// The concrete type of `DomainEvent` this subscriber handles.
    var eventType: DomainEvent.Type { T.self }

    /// Creates a new subscriber that performs the given action when the specified `DomainEvent` type is published.
    public init(action: @escaping (T) -> Void) {
        self.handlerAction = action
    }

    func handleEvent(_ domainEvent: DomainEvent) {
        guard let domainEvent = domainEvent as? T else { return }
        handlerAction(domainEvent)
    }
}

open class DomainEventHandler<T: DomainEvent>: DomainEventSubscriberProto {
    /// The concrete type of `DomainEvent` this subscriber handles.
    var eventType: DomainEvent.Type { T.self }

    /// Creates a new subscriber for a specific `DomainEvent`
    public init() {}

    func handleEvent(_ domainEvent: DomainEvent) {
        guard let domainEvent = domainEvent as? T else { return }
        handle(event: domainEvent)
    }

    open func handle(event: T) {
        fatalError("Must override concrete handler func")
    }
}

public protocol AnyDomainEventHandler {
    func handleEvent(_ event: DomainEvent)
}
