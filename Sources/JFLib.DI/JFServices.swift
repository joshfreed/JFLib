import Foundation

public class JFServices {
    static private(set) var shared: JFServices!

    private let resolver: JFServiceResolver

    private init(resolver: JFServiceResolver) {
        self.resolver = resolver
    }

    public static func initialize(resolver: JFServiceResolver) {
        assert(shared == nil)
        shared = .init(resolver: resolver)
    }

    public static func resolve<T>() throws -> T {
        try shared.resolve()
    }

    func resolve<T>() throws -> T {
        try resolver.resolve()
    }
}
