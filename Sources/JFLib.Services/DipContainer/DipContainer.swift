import Foundation
import Dip

public class DipContainer: JFServiceContainer {
    public let container: DependencyContainer

    public init() {
        self.container = DependencyContainer()
    }

    public func resolve<T>() throws -> T {
        try container.resolve()
    }
}
