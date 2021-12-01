import XCTest
@testable import JFLib_Services

class InjectedTests: XCTestCase {
    let container = TestContainer()

    override func setUpWithError() throws {
        JFServices.initialize(container: container)
        container.dep = Dependency(value: "Instance 1")
    }

    override func tearDownWithError() throws {
        JFServices.shared.deinitialize()
    }

    func test_sets_dependency_from_empty_constructur() throws {
        let service = Service()
        XCTAssertEqual("Instance 1", service.getValue())
    }

    func test_override_via_constructor() throws {
        let dep = Dependency(value: "Instance 2")
        let service = Service(dep: dep)
        XCTAssertEqual("Instance 2", service.getValue())
    }
}

extension InjectedTests {

    class TestContainer: JFServiceContainer {
        var dep: Dependency!

        func register<T>(_ factory: @escaping () -> T) {}
        func register<T, A>(_ factory: @escaping (A) -> T) {}
        func register<T, A, B>(_ factory: @escaping (A, B) -> T) {}
        func register<T, A, B, C>(_ factory: @escaping (A, B, C) -> T) {}
        func register<T, A, B, C, D>(_ factory: @escaping (A, B, C, D) -> T) {}
        func register<T, A, B, C, D, E>(_ factory: @escaping (A, B, C, D, E) -> T) {}
        func register<P, T>(_ protocol: P.Type, _ factory: @escaping () -> T) {}
        func register<P, T, A>(_ protocol: P.Type, _ factory: @escaping (A) -> T) {}
        func register<P, T, A, B>(_ protocol: P.Type, _ factory: @escaping (A, B) -> T) {}
        func register<P, T, A, B, C>(_ protocol: P.Type, _ factory: @escaping (A, B, C) -> T) {}
        func register<P, T, A, B, C, D>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D) -> T) {}
        func register<P, T, A, B, C, D, E>(_ protocol: P.Type, _ factory: @escaping (A, B, C, D, E) -> T) {}

        func resolve<T>() throws -> T {
            if let dep = dep as? T { return dep }
            throw ServiceNotFound()
        }
    }

    struct ServiceNotFound: Error {}

    class Dependency {
        let value: String

        init(value: String) {
            self.value = value
        }
    }

    class Service {
        @Injected var dep1: Dependency

        init() {}

        init(dep: Dependency) {
            self.dep1 = dep
        }

        func getValue() -> String {
            return dep1.value
        }
    }

}
