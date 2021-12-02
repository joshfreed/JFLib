import Foundation

internal var __date_currentImpl: () -> Date = { Date() }

extension Date {
    /// Returns current date
    /// Please replace `Date()` and `Date(timeIntervalSinceNow:)` with `Date.current`
    public static var current: Date {
        __date_currentImpl()
    }
}
