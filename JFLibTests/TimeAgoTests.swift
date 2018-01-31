//
//  TimeAgoTests.swift
//  JFLibTests
//
//  Created by Josh Freed on 1/30/18.
//  Copyright © 2018 Josh Freed. All rights reserved.
//

import XCTest
@testable import JFLib

class TimeAgoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShortTimeAgo() {
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:00:01", then: "2018-01-30 10:00:00"), "1s")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:00:59", then: "2018-01-30 10:00:00"), "59s")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:01:00", then: "2018-01-30 10:00:00"), "1m")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:01:59", then: "2018-01-30 10:00:00"), "1m")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:02:13", then: "2018-01-30 10:00:00"), "2m")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 10:59:59", then: "2018-01-30 10:00:00"), "59m")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 11:00:00", then: "2018-01-30 10:00:00"), "1h")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-30 23:59:59", then: "2018-01-30 10:00:00"), "13h")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-31 00:00:00", then: "2018-01-30 10:00:00"), "14h")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-31 09:59:59", then: "2018-01-30 10:00:00"), "23h")
        XCTAssertEqual(shortTimeAgo(now: "2018-01-31 10:00:00", then: "2018-01-30 10:00:00"), "1d")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-01 09:59:59", then: "2018-01-30 10:00:00"), "1d")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-01 10:00:00", then: "2018-01-30 10:00:00"), "2d")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-06 09:59:59", then: "2018-01-30 10:00:00"), "6d")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-06 10:00:00", then: "2018-01-30 10:00:00"), "1w")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-13 10:00:00", then: "2018-01-30 10:00:00"), "2w")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-20 10:00:00", then: "2018-01-30 10:00:00"), "3w")
        XCTAssertEqual(shortTimeAgo(now: "2018-02-27 10:00:00", then: "2018-01-30 10:00:00"), "4w")
        XCTAssertEqual(shortTimeAgo(now: "2018-03-06 10:00:00", then: "2018-01-30 10:00:00"), "1mo")
        XCTAssertEqual(shortTimeAgo(now: "2019-01-30 09:59:59", then: "2018-01-30 10:00:00"), "11mo")
        XCTAssertEqual(shortTimeAgo(now: "2019-01-30 10:00:00", then: "2018-01-30 10:00:00"), "1y")
        XCTAssertEqual(shortTimeAgo(now: "2022-01-30 11:00:00", then: "2018-01-30 10:00:00"), "4y")
    }
    
    func testShortTimeAgo_worksEvenIfTheDatesAreSwitchedOrder() {
        let earlier = Date.makeDate(from: "2018-01-30 10:00:00")!
        let later = Date.makeDate(from: "2018-01-30 23:59:59")!
        let actual = later.jpfShortTimeAgo(since: earlier)
        XCTAssertEqual(actual, "13h")
    }
    
    //
    // Helper Funcs
    //
    
    private func shortTimeAgo(now: String, then: String) -> String {
        let earlier = Date.makeDate(from: then)!
        let later = Date.makeDate(from: now)!
        return earlier.jpfShortTimeAgo(since: later)
    }
}
