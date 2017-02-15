//
//  TaskTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class TaskTests: XCTestCase {
    func testTask() {
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
        
        XCTAssertNotNil(task, "Task doesn't exists")
        XCTAssertEqual(task.isCancelled, false, "Task shouldn't be cancelled")
        XCTAssertEqual(task.isExecuting, false, "Task shouldn't execute")
        XCTAssertEqual(task.isFinished, false, "Task shouldn't be finished")
        XCTAssertEqual(task.forceRefresh, forceRefresh, "forceRefresh value is different")
        XCTAssertEqual(task.url, url, "URL doesn't match")
        XCTAssertNil(task.urlSessionTask, "URLSessionTask should be nil")
    }
    
    func testCancelingTask() {
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
            completion: completion)
        task.cancel()
        
        XCTAssertNotNil(task, "Operation doesn't exists")
        XCTAssertEqual(task.isCancelled, true, "Task should be cancelled")
        XCTAssertEqual(task.isExecuting, false, "Task shouldn't execute")
        XCTAssertEqual(task.isFinished, false, "Task shouldn't be finished")
        XCTAssertEqual(task.forceRefresh, forceRefresh, "forceRefresh value is different")
        XCTAssertEqual(task.url, url, "URL doesn't match")
        XCTAssertNil(task.urlSessionTask, "URLSessionTask should be nil")
    }
    
    func testStartingTask() {
        let networkExpectation = expectation(description: "network expectation")
        
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        let forceRefresh = false
        let provider = FakeNetworkProvider()
        let completion: STXImageOperationCompletion = { data, error in
            XCTAssertNotNil(data, "Data shouldn't be nil")
            XCTAssertNil(error, "Error should be nil")
            networkExpectation.fulfill()
        }
        let task = Task(
            url: url,
            forceRefresh: forceRefresh,
            provider: provider,
            progress: nil,
            completion: completion)
        let queue = OperationQueue()
        queue.addOperation(task)
        
        XCTAssertNotNil(task, "Operation doesn't exists")
        XCTAssertEqual(task.isCancelled, false, "Task shouldn't be cancelled")
        XCTAssertEqual(task.isExecuting, true, "Task should execute")
        XCTAssertEqual(task.isFinished, false, "Task shouldn't be finished")
        XCTAssertEqual(task.forceRefresh, forceRefresh, "forceRefresh value is different")
        XCTAssertEqual(task.url, url, "URL doesn't match")
        
        waitForExpectations(timeout: 30) { error in
            XCTAssertEqual(task.isFinished, true, "Task should be finished")
            XCTAssertNotNil(task.urlSessionTask, "URLSessionTask shouldn't be nil")
        }
    }
}
