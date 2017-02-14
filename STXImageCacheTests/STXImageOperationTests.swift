//
//  STXImageOperationTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class STXImageOperationTests: XCTestCase {
    func testOperation() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        let forceRefresh = false
        let provider = NetworkProvider(imageDownloader: ImageDownloader(configuration: URLSessionConfiguration.default))
        let completion: STXImageOperationCompletion = { data, error in
            
        }
        let task = Task(
            url: url,
            forceRefresh: forceRefresh,
            provider: provider,
            progress: nil,
            completion: completion
        )
        let operation = STXImageOperation(task: task)
        
        XCTAssertNotNil(operation, "Operation doesn't exists")
        XCTAssertEqual(operation.isCancelled, false, "Operation shouldn't be cancelled")
        XCTAssertEqual(operation.isExecuting, false, "Operation shouldn't execute")
        XCTAssertEqual(operation.isFinished, false, "Operation shouldn't be finished")
        XCTAssertEqual(operation.url, url, "URL doesn't match")
    }
    
    func testCancelingOperation() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        let forceRefresh = false
        let provider = NetworkProvider(imageDownloader: ImageDownloader(configuration: URLSessionConfiguration.default))
        let completion: STXImageOperationCompletion = { data, error in
            
        }
        let task = Task(
            url: url,
            forceRefresh: forceRefresh,
            provider: provider,
            progress: nil,
            completion: completion
        )
        let operation = STXImageOperation(task: task)
        operation.cancel()
        
        XCTAssertNotNil(operation, "Operation doesn't exists")
        XCTAssertEqual(operation.isCancelled, true, "Operation should be cancelled")
        XCTAssertEqual(operation.isExecuting, false, "Operation shouldn't execute")
        XCTAssertEqual(operation.isFinished, false, "Operation shouldn't be finished")
        XCTAssertEqual(operation.url, url, "URL doesn't match")
    }
}
