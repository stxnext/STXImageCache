//
//  ThreadsManagerTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class ThreadsManagerTests: XCTestCase {
    func testCriticalSection() {
        let object = 1
        let threadsManager = ThreadsManager<Int>()
        var result = 0
        
        let group = DispatchGroup()
        for _ in 0..<1000 {
            group.enter()
            let queue = DispatchQueue.global()
            queue.async {
                threadsManager.lock(forObject: object)
                result += 1
                XCTAssertEqual(result, 1, "result is invalid")
                result -= 1
                XCTAssertEqual(result, 0, "result is invalid")
                threadsManager.unlock(forObject: object)
                group.leave()
            }
        }
        group.wait()
    }
}
