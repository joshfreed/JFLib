import Foundation

public class JFServices {
    static private(set) var shared: JFServices!

    private let container: JFServiceContainer

    private init(container: JFServiceContainer) {
        self.container = container
    }

    public static func initialize(container: JFServiceContainer) {
        assert(shared == nil)
        shared = .init(container: container)
    }

    public static func resolve<T>() throws -> T {
        try shared.resolve()
    }

    func resolve<T>() throws -> T {
        try container.resolve()
    }

    func deinitialize() {
        JFServices.shared = nil
    }
}
