import Foundation

@propertyWrapper
public struct Injected<T> {
    public var wrappedValue: T { try! JFServices.resolve() }
    public init() {}
}
