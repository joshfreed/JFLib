import Foundation

public protocol JFServiceContainer {
    func resolve<T>() throws -> T
}
