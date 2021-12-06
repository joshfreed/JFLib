import Foundation

public protocol DomainEvent {}

/// Helper class for domain entities to append events that will be published after the application transaction commits.
public final class DomainEvents {
    /// Adds a domain event raised by the domain
    public static func add<T: DomainEvent>(_ domainEvent: T) {
        DomainEventPublisher.shared.add(domainEvent)
    }
}
