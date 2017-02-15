//
//  MemoryProviderTests.swift
//  STXImageCache
//
//  Created by Norbert Sroczyński on 14.02.2017.
//  Copyright © 2017 STX Next Sp. z o.o. All rights reserved.
//

import XCTest
@testable import STXImageCache

class MemoryProviderTests: XCTestCase {
    func testExistingData() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        
        let downloadExpectation = expectation(description: "download expectation")
        
        let dataProvider = FakeProvider()
        let provider = MemoryProvider(childProvider: dataProvider)
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertEqual(dataProvider.data(), data, "data is different")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testNotExistingData() {
        let url = URL(string: "https://raw.githubusercontent.com/stxnext/STXImageCache/master/STXImageCache_Logo.png")!
        
        let downloadExpectation = expectation(description: "download expectation")
        
        let provider = MemoryProvider(childProvider: nil)
        _ = provider.get(fromURL: url, forceRefresh: false, progress: nil) { data, error in
            XCTAssertNil(data, "data should be nil")
            XCTAssertNil(error, "error should be nil")
            downloadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
}
