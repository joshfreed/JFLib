import Foundation
import Dip

public class DipContainer: JFServiceContainer {
    private let container: DependencyContainer

    public init() {
        self.container = DependencyContainer()
    }

    public func register<T>(_ factory: @escaping () -> T) {
        container.register(factory: factory)
    }

    public func register<T, A>(_ factory: @escaping (A) -> T) {
        container.register(factory: factory)
    }

    public func register<T, A, B>(_ factory: @escaping (A, B) -> T) {
        container.register(factory: factory)
    }

    public func register<T, A, B, C>(_ factory: @escaping (A, B, C) -> T) {
        container.register(factory: factory)
    }

    public func register<T, A, B, C, D>(_ factory: @escaping (A, B, C, D) -> T) {
        container.register(factory: factory)
    }

    public func register<T, A, B, C, D, E>(_ factory: @escaping (A, B, C, D, E) -> T) {
        container.register(factory: factory)
    }

    public func register<P, T>(_ protocol: P.Type, _ factory: @escaping () -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func register<P, T, A>(_ protocol: P.Type, _ factory: @escaping (A) -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func register<P, T, A, B>(_ protocol: P.Type, _ factory: @escaping (A, B) -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func register<P, T, A, B, C>(_ protocol: P.Type, _ factory: @escaping (A, B, C) -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func register<P, T, A, B, C, D>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D) -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func register<P, T, A, B, C, D, E>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D, E) -> T) {
        container.register(factory: factory).implements(P.self)
    }

    public func resolve<T>() throws -> T {
        try container.resolve()
    }
}
