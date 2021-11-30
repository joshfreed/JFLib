import Foundation

public protocol JFServiceContainer {
    func register<T>(_ factory: @escaping () -> T)
    func register<T, A>(_ factory: @escaping (A) -> T)
    func register<T, A, B>(_ factory: @escaping (A, B) -> T)
    func register<T, A, B, C>(_ factory: @escaping (A, B, C) -> T)
    func register<T, A, B, C, D>(_ factory: @escaping (A, B, C, D) -> T)
    func register<T, A, B, C, D, E>(_ factory: @escaping (A, B, C, D, E) -> T)

    func register<P, T>(_ protocol: P.Type, _ factory: @escaping () -> T)
    func register<P, T, A>(_ protocol: P.Type, _ factory: @escaping (A) -> T)
    func register<P, T, A, B>(_ protocol: P.Type, _ factory: @escaping (A, B) -> T)
    func register<P, T, A, B, C>(_ protocol: P.Type, _ factory: @escaping (A, B, C) -> T)
    func register<P, T, A, B, C, D>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D) -> T)
    func register<P, T, A, B, C, D, E>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D, E) -> T)

    func resolve<T>() throws -> T
}
